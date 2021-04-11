extends Node2D

var HOR_SPEED = 8

var health = 200

var dy = 0
var dx = 0

var state = "falling"
var standing_on = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Scene ready...")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	$walkzilla/HealthbarNode.set_health(health)
	
	var walkzilla = $walkzilla
	
	if Input.is_key_pressed(KEY_LEFT):
		dx = -HOR_SPEED
		walkzilla.dir_left()
		walkzilla.is_walking = true
	elif Input.is_key_pressed(KEY_RIGHT):
		dx = HOR_SPEED
		walkzilla.dir_right()
		walkzilla.is_walking = true
	else:
		dx = 0
		walkzilla.is_walking = false
		
	var w = walkzilla.get_width()
	var h = walkzilla.get_height()
	var x = walkzilla.position.x
	var y = walkzilla.position.y
	var platforms = $map.get_children()

	var humans = $humans.get_children()
	
	for human in humans:
		var human_w = human.texture.get_width() * human.scale[0]
		var human_h = human.texture.get_height() * human.scale[1]	
		if x + w > human.position.x \
			and x < human.position.x + human_w \
			and y + h > human.position.y \
			and y < human.position.y + human_h:
				print("Colliding with human: " + str(human))
				human.queue_free()
				$SoundEat.play()
				health += 10
				
		
		
	var platforms_underneath = []
	
	for p in platforms:
		var platform_w = p.texture.get_width() * p.scale[0]
		if x < p.position.x + platform_w and x + w > p.position.x:
			platforms_underneath.append(p)
	
	if state == "standing":
		if not standing_on in platforms_underneath:
			state = "falling"
			print("Fell off from " + str(standing_on))
			standing_on = null
		else:
			if Input.is_key_pressed(KEY_SPACE):
				dy = -13
				print("Jumped")
				$SoundJump.play()
				state = "jumping"
	else:
		dy += 0.5
		if dy > 0:
			if platforms_underneath:
				for p in  platforms_underneath:
					if y + h <= p.position.y and y + h + dy >= p.position.y:
						print("Landed on " + str(p))
						health -= 5
						$SoundLand.play()
						state = "standing"
						standing_on = p
						dy = 0
						walkzilla.position.y = p.position.y - h
			else:
				state = "falling"
		else:
			state = "jumping"
			
	walkzilla.position.x += dx
	walkzilla.position.y += dy
	
	if walkzilla.position.y > 1000:
		walkzilla.flip_v = true
			
		if walkzilla.position.y > 2000:
			get_tree().reload_current_scene()

			
