extends Sprite


var HOR_SPEED = 5

var dy = 0
var dx = 0
var block_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("I am ready")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.position.x += dx
	self.position.y += dy
	
	if Input.is_key_pressed(KEY_LEFT):
		dx = -HOR_SPEED
	elif Input.is_key_pressed(KEY_RIGHT):
		dx = HOR_SPEED
	else:
		dx = 0
		
	if not block_down:
		dy += 0.5
		if self.position.y > 400:
			# we just landed
			block_down = true
			self.position.y = 400
			dy = 0
	else:
		if Input.is_key_pressed(KEY_SPACE):
			dy = -10
			block_down = false

			
	
	
	
