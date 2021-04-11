extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_jumping = false
var cooldown = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown = randf()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown -= delta
	if cooldown <= 0:
		cooldown = 0.5
		var dy = 10 if is_jumping else -10
		self.position.y += dy
		is_jumping = not is_jumping
