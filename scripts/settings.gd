extends Control

@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Master")
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
