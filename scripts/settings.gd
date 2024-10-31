extends Control

# Fungsi untuk slider music
func _on_music_h_slider_value_changed(value: float) -> void:
	$VBoxContainer/HBoxContainer/MusicPersentase.text = str(value) + "%"

# Fungsi untuk slider sfx
func _on_sfx_h_slider_value_changed(value: float) -> void:
	$VBoxContainer/HBoxContainer2/SfxPersentase.text = str(value) + "%"
	var volume_db = -80 + (value / 100) * 80
	$AudioStreamPlayer.volume_db = volume_db
	

func _on_back_button_pressed() -> void:
	$AudioStreamPlayer.play()
	# Kembali ke scene utamas
	#get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
