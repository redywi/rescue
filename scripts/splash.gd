extends Node

func _ready():
	await get_tree().create_timer(2.5).timeout

	_go_to_main_menu()

func _go_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
