extends Node2D

var HOR_SPEED = 5

var dy = 0
var dx = 0

var state = "falling"

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
		
	var w = walkzilla.texture.get_width() * walkzilla.scale[0] / 12.0
	var h = walkzilla.texture.get_height() * walkzilla.scale[1]
	var x = walkzilla.position.x
	var y = walkzilla.position.y
	var platform = $platform
	var platform_w = platform.texture.get_width() * platform.scale[0]
	
	var is_over_platform = x < platform.position.x + platform_w \
			and x + w > platform.position.x
			
	
	if state == "standing":
		if not is_over_platform:
			state = "falling"
		else:
			if Input.is_key_pressed(KEY_SPACE):
				dy = -10
				state = "jumping"
	else:
		dy += 0.5
		if dy > 0:
			if is_over_platform and y + h < platform.position.y and y + h + dy >= platform.position.y:
				state = "standing"
				dy = 0
			else:
				state = "falling"
		else:
			state = "jumping"
			
	walkzilla.position.x += dx
	walkzilla.position.y += dy
			
