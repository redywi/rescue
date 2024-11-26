extends Control

func _ready() -> void:
	if main_music.playing == false:
		main_music.play()
	else:
		pass

func _on_button_level_1_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_1.tscn")

func _on_button_level_2_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_2.tscn")

func _on_button_level_3_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_3.tscn")
	
func _on_button_level_4_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_4.tscn")

func _on_button_level_5_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_5.tscn")

func _on_button_level_6_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_6.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
