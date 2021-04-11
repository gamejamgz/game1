extends Node2D

var HOR_SPEED = 8

var health = 200

var dy = 0
var dx = 0

enum {STANDING, JUMPING, FALLING}

var state = FALLING
var standing_on = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Scene ready...")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	health -= 15 * delta
	if health <= 0:
		get_tree().reload_current_scene()
	
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
	var platforms = []
	for child in $map.get_children():
		if child.get_class() == "Node2D":
			for moving_platform in child.get_children():
				platforms.append(moving_platform)
		else:
			platforms.append(child)
		
	
	var moving_platforms = $map.get_node("moving_platforms").get_children()
	
	for moving_platform in moving_platforms: 
		var dx = moving_platform.update_position(delta)
		if standing_on == moving_platform:
			walkzilla.position.x += dx

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
				health += 50
				walkzilla.eat()
		
	var platforms_underneath = []
	
	for p in platforms:
		var platform_w = p.texture.get_width() * p.scale[0]
		if x < p.position.x + platform_w and x + w > p.position.x:
			platforms_underneath.append(p)
	
	if state == STANDING:
		if not standing_on in platforms_underneath:
			state = FALLING
			print("Fell off from " + str(standing_on))
			standing_on = null
		else:
			if Input.is_key_pressed(KEY_UP):
				dy = -13
				print("Jumped")
				$SoundJump.play()
				state = JUMPING
				standing_on = null
	else:
		dy += 0.5
		if dy > 0:
			if platforms_underneath:
				for p in  platforms_underneath:
					if y + h <= p.position.y and y + h + dy >= p.position.y:
						print("Landed on " + str(p))
						
						$SoundLand.play()
						state = STANDING
						standing_on = p
						dy = 0
						walkzilla.position.y = p.position.y - h
			else:
				state = FALLING
		else:
			state = JUMPING
			
	walkzilla.position.x += dx
	walkzilla.position.y += dy
	
	if walkzilla.position.y > 1000:
		walkzilla.die()
			
		if walkzilla.position.y > 2000:
			get_tree().reload_current_scene()

			
