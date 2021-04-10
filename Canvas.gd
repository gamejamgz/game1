extends Node2D

var HOR_SPEED = 8

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
		
	var w = walkzilla.get_width()
	var h = walkzilla.get_height()
	var x = walkzilla.position.x
	var y = walkzilla.position.y
	var platforms = [$platform1, $platform2]
	
	var is_over_platform = null
	
	for p in platforms:
		var platform_w = p.texture.get_width() * p.scale[0]
		if x < p.position.x + platform_w and x + w > p.position.x:
			is_over_platform = p
			
	
	if state == "standing":
		if not is_over_platform:
			state = "falling"
		else:
			if Input.is_key_pressed(KEY_SPACE):
				dy = -15
				state = "jumping"
	else:
		dy += 0.5
		if dy > 0:
			if is_over_platform:
				if y + h < is_over_platform.position.y \
				and y + h + dy >= is_over_platform.position.y:
					state = "standing"
					dy = 0
					walkzilla.position.y = is_over_platform.position.y - h
			else:
				state = "falling"
		else:
			state = "jumping"
			
	walkzilla.position.x += dx
	walkzilla.position.y += dy
			
