extends Node2D

var HOR_SPEED = 8

var dy = 0
var dx = 0

var state = "falling"
var standing_on = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Scene ready...")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
	var platforms = [$platform1, $platform2, 
					$platform3, $platform4, $platform5,
					$platform6, $platform7, $platform8]
	
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

			
