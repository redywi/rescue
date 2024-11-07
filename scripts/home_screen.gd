extends Control

# Fungsi yang dipanggil saat scene dimuat
func _ready() -> void:
	# Memainkan audio secara otomatis saat scene dimuat
	$AudioStreamPlayer.play()

	# Fungsi ketika tombol Start ditekan
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/select_level.tscn")
	
	
# Fungsi untuk tombol Settings 
func _on_settings_button_pressed():
	# Ganti ke scene pengaturan
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

# Fungsi untuk tombol Exit
func _on_exit_button_pressed():
	# Menutup aplikasi
	get_tree().quit()
