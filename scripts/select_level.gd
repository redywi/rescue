extends Control

# Fungsi untuk ketika Level 1 dipilih
func _on_button_level_1_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

# Fungsi untuk ketika Level 2 dipilih
func _on_button_level_2_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene("res://scenes/level_2.tscn")

# Fungsi untuk ketika Level 3 dipilih
func _on_button_level_3_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene("res://scenes/level_3.tscn")

# Fungsi untuk ketika Level 4 dipilih
func _on_button_level_4_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene("res://scenes/level_4.tscn")

# Fungsi untuk ketika Level 5 dipilih
func _on_button_level_5_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene("res://scenes/level_5.tscn")
	
# Fungsi untuk ketika Level boss dipilih
func _on_button_level_boss_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene("res://scenes/level_boss.tscn")

# Fungsi untuk tombol Back
func _on_back_button_pressed() -> void:
	# Kembali ke Main Menu
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
