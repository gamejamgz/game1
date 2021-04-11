extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var shoot_cooldown = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot_cooldown -= delta
	
	if shoot_cooldown <= 0:
		shoot_cooldown = (randf() * 6) + 2
		print(str(self) + " is shooting")
		
		var sprite = Sprite.new()
		print(sprite)
		
		sprite.texture = load("res://bullet.png")
		sprite.position = self.position
