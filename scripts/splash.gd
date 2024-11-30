extends Node


func _ready():
	# Menunggu selama 3 detik sebelum melanjutkan
	await get_tree().create_timer(2.5).timeout

	# Pindah ke scene Main Menu
	_go_to_main_menu()

func _go_to_main_menu():
	# Ganti scene ke Main Menu
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
