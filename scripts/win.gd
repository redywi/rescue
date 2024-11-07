extends Control

func _on_exit_pressed():
	global.you_won = false
	global.sun_value = 100
	global.danger_level = 0
	get_tree().change_scene_to_file("res://scenes/select_level.tscn")
