extends Control

# Fungsi untuk slider music
func _on_music_h_slider_value_changed(value: float) -> void:
	$VBoxContainer/HBoxContainer/MusicPersentase.text = str(value) + "%"

# Fungsi untuk slider sfx
func _on_sfx_h_slider_value_changed(value: float) -> void:
	$VBoxContainer/HBoxContainer2/SfxPersentase.text = str(value) + "%"
	

func _on_back_button_pressed() -> void:
	# Kembali ke scene utamas
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
