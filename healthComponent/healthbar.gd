extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health=300


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_health(new_health):
	health=new_health
	self.update_health()

func update_health():
	#$Healthbar.rect_size = (Vector2(health,78))
	$Healthbar.margin_right = health * 3
	#print(health)
	#print($Healthbar.rect_size)





