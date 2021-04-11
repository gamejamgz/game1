extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	counter += 0.1
	self.position.x = 100+sin(counter)*100
