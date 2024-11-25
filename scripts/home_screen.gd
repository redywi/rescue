extends Control

func _ready() -> void:
	main_music.play()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/select_level.tscn")
	
func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
