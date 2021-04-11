extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var shoot_cooldown = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot_cooldown -= delta
	
	if shoot_cooldown <= 0:
		shoot_cooldown = (randf() * 6) + 2
		print(str(self) + " is shooting")
		
		var bullet = Bullet.new()
		
		bullet.texture = load("res://bullet.png")
		bullet.position = self.position
		bullet.scale[0] = 8
		bullet.scale[1] = 4
		var bullets = get_node("/root/Canvas/bullets")
		bullets.add_child(bullet)
		
		get_node("/root/Canvas/SoundSoldierShoot").play()
