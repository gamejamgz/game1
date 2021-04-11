extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_position(delta):
	counter += 0.05
	var dx = 100 + sin(counter) * 100 - self.position.x
	self.position.x += dx
	return dx
