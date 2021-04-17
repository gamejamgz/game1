extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var game_scene
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().paused = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	counter += 1
	$CanvasLayer/counter.text = str(counter)
	#$counter.get_tree().reload_current_scene()

func set_gamescene(new_game_scene):
	print("setting game scene")
	game_scene = new_game_scene

func show_menu():
	print("show menu")
	get_tree().paused = true
	#self.visible = true

func start_game():
	print("start game")
	#get_tree().reload_current_scene()
	#get_parent().get_child(0).print_tree()
	#print(get_parent().get_child(0).name)
	get_tree().change_scene("res://MyScene.tscn")
	#get_node("/root/Canvas").reload_current_scene()
	#get_tree().get_root().get_node("rootNodeName")
	#self.visible = false
		
func _on_Button_pressed():
	self.start_game()
