extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_menu():
	print("show menu")
	$CanvasLayer/VBoxContainer/HBoxContainer.visible = true

func _on_Button_pressed():
	# Reloading the scene
	# Based on this
	# https://godotengine.org/qa/24773/how-to-load-and-change-scenes

	print("button pressed")
	
	get_node("/root/GameContainer").remove_child(get_node("/root/GameContainer/Game"))
	
	
	var game_resource = load("res://Game.tscn")
	var Game = game_resource.instance()
	get_node("/root/GameContainer").add_child(Game)
	
	$CanvasLayer/VBoxContainer/HBoxContainer.visible = false
	
	get_tree().paused = false
