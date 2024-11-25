extends Control

func _ready() -> void:
	if main_music.playing == false:
		main_music.play()
	else:
		pass

func _on_button_level_1_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_1.tscn")

# Fungsi untuk ketika Level 2 dipilih
func _on_button_level_2_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_2.tscn")

# Fungsi untuk ketika Level 3 dipilih
func _on_button_level_3_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_3.tscn")

# Fungsi untuk ketika Level 4 dipilih
func _on_button_level_4_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_4.tscn")

# Fungsi untuk ketika Level 5 dipilih
func _on_button_level_5_pressed() -> void:
	main_music.stop()
	get_tree().change_scene_to_file("res://scenes/lawn_5.tscn")
	
# Fungsi untuk ketika Level boss dipilih
func _on_button_level_boss_pressed() -> void:
	pass # Replace with function body.
	#main_music.stop()
	#get_tree().change_scene_to_file("res://scenes/lawn_6.tscn")

# Fungsi untuk tombol Back
func _on_back_button_pressed() -> void:
	# Kembali ke Main Menu
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
