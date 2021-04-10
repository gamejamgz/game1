extends Sprite

# Declare member variables here. Examples:
var nextframe_countdown = 0

var is_walking = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func dir_left():
	self.flip_h = true;
	
func dir_right():
	self.flip_h = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(not is_walking):
		return
	
	if(nextframe_countdown <= 0):
		nextframe_countdown = 5
		next_frame()
	else:
		nextframe_countdown -=1

func next_frame():
	if(self.frame < 4):
		self.frame +=1
	else:
		self.frame = 0
		
func get_width():
	var width = (self.texture.get_size()[0]/self.hframes)*self.scale[0]
	return width
	
func get_height():
	var height = (self.texture.get_size()[1]/self.vframes)*self.scale[1]
	return height
