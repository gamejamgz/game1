extends Node2D

# Declare member variables here. Examples:
var nextwalk_countdown = 0

var eat_countdown = 0

var is_walking = false
var walk_frame = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func dir_left():
	$sprite.flip_h = true;
	
func dir_right():
	$sprite.flip_h = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print("eat_countdown ", eat_countdown)
	if(eat_countdown > 0):
		eat_countdown -= 1
		print("eat_countdown ", eat_countdown)
	
	if(is_walking):
		if(nextwalk_countdown <= 0):
			nextwalk_countdown = 5
			next_walk()
		else:
			nextwalk_countdown -=1
		
	update_frame()

func eat():
	eat_countdown = 10
	print("is eating called ", eat_countdown)
	update_frame()
	
func is_eating():
	return eat_countdown > 0

func die():
	$sprite.flip_v = true
	

func next_walk():
	
	if(walk_frame < 4):
		walk_frame +=1
	else:
		walk_frame = 0
		
func update_frame():
	if(eat_countdown):
		$sprite.frame=5
	else:
		$sprite.frame = walk_frame
		
func get_width():
	var width = ($sprite.texture.get_size()[0]/$sprite.hframes)*$sprite.scale[0]
	return width
	
func get_height():
	var height = ($sprite.texture.get_size()[1]/$sprite.vframes)*$sprite.scale[1]
	return height
