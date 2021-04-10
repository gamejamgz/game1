extends Node2D

var HOR_SPEED = 5

var dy = 0
var dx = 0
var block_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Scene ready...")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	var walkzilla = $walkzilla
	
	var godzilla = walkzilla
	
	
	
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
		
		
	var w = godzilla.texture.get_width() * godzilla.scale[0]
	var h = godzilla.texture.get_height() * godzilla.scale[1]
	var x = godzilla.position.x
	var y = godzilla.position.y
	var platform = $platform
	var platform_w = platform.texture.get_width() * platform.scale[0]
	
	if not block_down:
		dy += 0.5
	
	if y + h < platform.position.y \
			and y + h + dy >= platform.position.y \
			and x < platform.position.x + platform_w \
			and x + w > platform.position.x:
		# Standing on platform
		block_down = true
		godzilla.position.y = platform.position.y - h
		dy = 0
	
		
	if block_down:
		if Input.is_key_pressed(KEY_SPACE):
			dy = -10
			block_down = false

	godzilla.position.x += dx
	godzilla.position.y += dy
			
	
	
		
