extends Sprite

class_name Bullet

var time_until_expiration = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x -= delta * 300
	time_until_expiration -= delta
	
	if time_until_expiration <= 0:
		self.queue_free()
