extends Node2D

@onready var hi_light = $hi_light
@onready var shovel = $shovel
@onready var shooter_seed1 = $seed_slots/shooter_seed1
@onready var bloom_seed2 = $seed_slots/bloom_seed2
@onready var hog_seed3 = $seed_slots/hog_seed3
@onready var hedgehog_seed4 = $seed_slots/hedgehog_seed4
@onready var sun_value = $sun_value/Label
@onready var timer = $Timer
@onready var sun_timer = $sun_timer
@onready var countdown = $countdown
@onready var cooldown_seed1 = $seed_slots/cooldown_bar_seed1/TextureProgressBar
@onready var cooldown_seed2 = $seed_slots/cooldown_bar_seed2/TextureProgressBar
@onready var cooldown_seed3 = $seed_slots/cooldown_bar_seed3/TextureProgressBar
@onready var cooldown_seed4 = $seed_slots/cooldown_bar_seed4/TextureProgressBar
@onready var cooldown_seed5 = $seed_slots/cooldown_bar_seed5/TextureProgressBar
@onready var cooldown_seed6 = $seed_slots/cooldown_bar_seed6/TextureProgressBar

var rng = RandomNumberGenerator.new()
var lawn_space = {}
var lawn_key_list = []
var current_seed = 0
var seed_list = [null, preload("res://scenes/pea_blaster.tscn"), preload("res://scenes/bee_hive.tscn"), preload("res://scenes/hog.tscn"), preload("res://scenes/hedgehog_bomb.tscn")]
var shove = false
var shovel_pos = Vector2(410, 25)
var pos
var start_sun_time = 1
var particle = preload("res://scenes/particles_square.tscn")

func _ready():
	music_3.play()
	sun_value.text = str(global.sun_value)
	sun_timer.start()

func enemy_spawning():
	var lane = rng.randi_range(1, 5)
	var pos_y
	match lane:
		1: pos_y = 199
		2: pos_y = 167
		3: pos_y = 135
		4: pos_y = 103
		5: pos_y = 71
	if rng.randf_range(0, 50000) < (global.danger_level):
		var butcher = load("res://scenes/butcher.tscn").instantiate()
		butcher.position = Vector2(496, pos_y)
		add_child(butcher)
		global.danger_level -= 1
	if rng.randf_range(0, 60000) < (global.danger_level):
		var helmet_butcher = load("res://scenes/helmet_butcher.tscn").instantiate()
		helmet_butcher.position = Vector2(496, pos_y)
		add_child(helmet_butcher)
		global.danger_level -= 1

func shovel_func(event):
	if shove and !event.pressed:
		shovel.position = shovel_pos
		shove = false
		shovel.z_index = 1
		return
	if pos.x > 390 and pos.x < 430 and pos.y > 9 and pos.y < 34 and event.pressed and !shove:
		shovel.z_index += 1
		shove = true

func shovel_key_func(event):
	if (shove and !event.pressed) or event.keycode != 83:
		shovel.position = shovel_pos
		shove = false
		shovel.z_index = 1
		return
	if event.pressed and event.keycode == 83:
		shovel.z_index += 1
		shove = true

func seed1_func(event):
	if !event.pressed:
		shooter_seed1.position = Vector2(80, 240)
		current_seed = 0
		shooter_seed1.z_index = 1
		return
	if pos.x > 64 and pos.x < 96 and pos.y > 240 and pos.y < 272 and event.pressed:
		shooter_seed1.z_index += 1
		current_seed = 1

func seed1_key_func(event):
	if (current_seed == 1 and !event.pressed) or event.keycode != 49:
		shooter_seed1.position = Vector2(80, 240)
		current_seed = 0
		shooter_seed1.z_index = 1
		return false
	if event.pressed and event.keycode == 49 and cooldown_seed1.value == 10000:
		shooter_seed1.z_index += 1
		current_seed = 1
		allbutone_slot_reset(1)
		return true

func seed2_func(event):
	if !event.pressed:
		bloom_seed2.position = Vector2(112, 240)
		current_seed = 0
		bloom_seed2.z_index = 1
		return
	if pos.x > 96 and pos.x < 128 and pos.y > 240 and pos.y < 272 and event.pressed:
		bloom_seed2.z_index += 1
		current_seed = 2

func seed2_key_func(event):
	if (current_seed == 2 and !event.pressed) or event.keycode != 50:
		bloom_seed2.position = Vector2(112, 240)
		current_seed = 0
		bloom_seed2.z_index = 1
		return false
	if event.pressed and event.keycode == 50 and cooldown_seed2.value == 10000:
		bloom_seed2.z_index += 1
		current_seed = 2
		allbutone_slot_reset(2)
		return true

func seed3_func(event):
	if !event.pressed:
		hog_seed3.position = Vector2(144, 240)
		current_seed = 0
		hog_seed3.z_index = 1
		return
	if pos.x > 128 and pos.x < 160 and pos.y > 240 and pos.y < 272 and event.pressed:
		hog_seed3.z_index += 1
		current_seed = 3

func seed3_key_func(event):
	if (current_seed == 3 and !event.pressed) or event.keycode != 51:
		hog_seed3.position = Vector2(144, 240)
		current_seed = 0
		hog_seed3.z_index = 1
		return false
	if event.pressed and event.keycode == 51 and cooldown_seed3.value == 10000:
		hog_seed3.z_index += 1
		current_seed = 3
		allbutone_slot_reset(3)
		return true
		
func seed4_func(event):
	if !event.pressed:
		hedgehog_seed4.position = Vector2(176, 240)
		current_seed = 0
		hedgehog_seed4.z_index = 1
		return
	if pos.x > 160 and pos.x < 192 and pos.y > 240 and pos.y < 272 and event.pressed:
		hedgehog_seed4.z_index += 1
		current_seed = 4

func seed4_key_func(event):
	if (current_seed == 4 and !event.pressed) or event.keycode != 52:
		hedgehog_seed4.position = Vector2(176, 240)
		current_seed = 0
		hedgehog_seed4.z_index = 1
		return false
	if event.pressed and event.keycode == 52 and cooldown_seed4.value == 10000:
		hedgehog_seed4.z_index += 1
		current_seed = 4
		allbutone_slot_reset(4)
		return true

func allbutone_slot_reset(slot_button):
	if slot_button != 1:
		shooter_seed1.position = Vector2(80, 240)
		shooter_seed1.z_index = 1
	if slot_button != 2:
		bloom_seed2.position = Vector2(112, 240)
		bloom_seed2.z_index = 1
	if slot_button != 3:
		hog_seed3.position = Vector2(144, 240)
		hog_seed3.z_index = 1
	if slot_button != 4:
		hedgehog_seed4.position = Vector2(176, 240)
		hedgehog_seed4.z_index = 1
	if slot_button != 5:
		pass
	if slot_button != 6:
		pass
	
func slotkey(event):
	if seed1_key_func(event):
		return
	elif seed2_key_func(event):
		return
	elif seed3_key_func(event):
		return
	elif seed4_key_func(event):
		return
	
	allbutone_slot_reset(0)

func level_won():
	music_3.stop()
	win_sound.play()
	get_node("win").visible = true
	allbutone_slot_reset(0)

func _input(event):
	if global.you_lost:
		return
	if event is InputEventKey:
		shovel_key_func(event)
		slotkey(event)
	
	if event is InputEventMouseButton:
		pos = event.position
		var x = int(pos.x / 32)
		var y = int((pos.y + 8)/32)
		
		
		#shovel plant from lawn
		if pos.x > 32 and pos.x < 448 and pos.y > 56 and pos.y < 216 and !event.pressed and shove and lawn_space.has(str(x) + str(y)):
			# Menghapus tanaman dari lawn_space
			remove_child(lawn_space[str(x) + str(y)])
			lawn_space[str(x) + str(y)].queue_free()
			lawn_space.erase(str(x) + str(y))
	
			for i in range(len(lawn_key_list)):
				if lawn_key_list[i] == (str(x) + str(y)):
					lawn_key_list.remove_at(i)
					break
					
		shovel_func(event)
		
		if (str(x) + str(y)) in lawn_space and !event.pressed:
			current_seed = 0
			allbutone_slot_reset(0)
			return
		
		#add plant in lawn from seed slot
		if pos.x > 32 and pos.x < 448 and pos.y > 56 and pos.y < 216:
			match current_seed:
				1:
					if (global.sun_value - 125 >= 0) and !event.pressed:
						global.sun_value_deficit += 125
					elif !event.pressed:
						current_seed = 0
						get_node("sun_value").modulate.g = 0.2
						get_node("sun_value").modulate.b = 0.2
				2:
					if (global.sun_value - 75 >= 0) and !event.pressed:
						global.sun_value_deficit += 75
					elif !event.pressed:
						current_seed = 0
						get_node("sun_value").modulate.g = 0.2
						get_node("sun_value").modulate.b = 0.2
				3:
					if (global.sun_value - 100 >= 0) and !event.pressed:
						global.sun_value_deficit += 100
					elif !event.pressed:
						current_seed = 0
						get_node("sun_value").modulate.g = 0.2
						get_node("sun_value").modulate.b = 0.2
				4: 
					if (global.sun_value - 175 >= 0) and !event.pressed:
						global.sun_value_deficit += 175
					elif !event.pressed:
						current_seed = 0
						get_node("sun_value").modulate.g = 0.2
						get_node("sun_value").modulate.b = 0.2
		
		if pos.x > 32 and pos.x < 448 and pos.y > 56 and pos.y < 216 and !event.pressed and current_seed != 0:
			var instance = seed_list[current_seed].instantiate()
			instance.position = hi_light.position
			instance.name = str(current_seed) + "_" + str(x) + str(y)
			instance.state = 0
			instance.last_state = 1
			lawn_space[str(x) + str(y)] = instance
			add_child(instance)
			lawn_key_list.append(str(x) + str(y))
			match current_seed:
				1:
					cooldown_seed1.value = 0
				2:
					cooldown_seed2.value = 0
				3:
					cooldown_seed3.value = 0
				4:
					cooldown_seed4.value = 0
				5:
					cooldown_seed5.value = 0
				6:
					cooldown_seed6.value = 0
			global.danger_level += 1
			allbutone_slot_reset(0)
			current_seed = 0
		
		if cooldown_seed1.value == 10000:
			seed1_func(event)
		if cooldown_seed2.value == 10000:
			seed2_func(event)
		if cooldown_seed3.value == 10000:
			seed3_func(event)
		if cooldown_seed4.value == 10000:
			seed4_func(event)
		
	#hilight
	elif event is InputEventMouseMotion:
		pos = event.position
		if pos.x > 32 and pos.x < 448 and pos.y > 56 and pos.y < 216:
			hi_light.position = Vector2(16 + 32 * int(pos.x / 32), 8 + 32 * int((pos.y + 8) / 32))
		else:
			hi_light.position = Vector2(-50, -50)

func _physics_process(delta):
	enemy_spawning()
	if shove:
		shovel.position = get_global_mouse_position() + Vector2(10, -10)
	elif current_seed == 1:
		shooter_seed1.position = get_global_mouse_position()
	elif current_seed == 2:
		bloom_seed2.position = get_global_mouse_position()
	elif current_seed == 3:
		hog_seed3.position = get_global_mouse_position()
	elif current_seed == 4:
		hedgehog_seed4.position = get_global_mouse_position()
	
	if global.danger_level > 0:
		global.danger_level += 3 * delta * global.speed
	
	sun_value.text = str(global.sun_value)
	
	clamp(get_node("sun_value").modulate.g, 0, 1)
	clamp(get_node("sun_value").modulate.r, 0, 1)
	clamp(get_node("sun_value").modulate.b, 0, 1)
	
	if global.sun_value_deficit > 0:
		global.sun_value -= 5
		global.sun_value_deficit -= 5
		get_node("sun_value").modulate.r = 1
		get_node("sun_value").modulate.g = 0.2
		get_node("sun_value").modulate.b = 0.2
	
	if global.sun_value_surplus > 0:
		global.sun_value += 5
		global.sun_value_surplus -= 5
		get_node("sun_value").modulate.r = 0.2
		get_node("sun_value").modulate.g = 1
		get_node("sun_value").modulate.b = 0.2
	
	if get_node("sun_value").modulate.r < 1:
		get_node("sun_value").modulate.r += 0.01 * global.speed
	
	if get_node("sun_value").modulate.g < 1:
		get_node("sun_value").modulate.g += 0.01 * global.speed
	
	if get_node("sun_value").modulate.b < 1:
		get_node("sun_value").modulate.b += 0.01 * global.speed
	
	cooldown_seed1.value += 20 * global.speed
	cooldown_seed2.value += 20 * global.speed
	cooldown_seed3.value += 20 * global.speed
	cooldown_seed4.value += 5 * global.speed
	cooldown_seed5.value += 20 * global.speed
	cooldown_seed6.value += 20 * global.speed
	
	sun_timer.start(sun_timer.time_left - (delta * (global.speed - 1)))
	if sun_timer.time_left < 0.5:
		sun_timer.emit_signal("timeout")
	
	if global.you_won == true:
		level_won()

func _on_timer_timeout():
	for i in lawn_key_list:
		if lawn_space[i].dead:
			if lawn_space[i].state < 2:
				global.leaf_value_surplus += 2
			elif lawn_space[i].state >= 2:
				global.leaf_value_surplus += 10
			lawn_space[i].queue_free()
			lawn_space.erase(i)
			global.danger_level -= 1
			for j in len(lawn_key_list):
				if lawn_key_list[j] == i:
					lawn_key_list.remove_at(j)
					break

func _on_sun_timer_timeout():
	if global.danger_level == 0:
		return
	var honey_drop = load("res://scenes/honey_drop.tscn").instantiate()
	honey_drop.position = self.position + Vector2(rng.randi_range(80, 400), -10)
	add_child(honey_drop)
	if start_sun_time < 20:
		start_sun_time += 0.5
	sun_timer.wait_time = start_sun_time
	sun_timer.start()


func _on_dead_area_area_entered(area):
	if area.name == "enemy":
		get_tree().paused = true
		global.you_lost = true
		get_node("dead").visible = true
		#get_node("pausetext").visible = false
		#get_node("non_pause").visible = false


func _on_button_restart_pressed() -> void:
	allbutone_slot_reset(0)
	get_tree().paused = false
	music_3.stop()
	main_music.play()
	global.speed = 1
	global.sun_value = 300
	global.sun_value_deficit = 0
	global.sun_value_surplus = 0
	global.danger_level = 0
	global.slime_count = 0
	global.you_lost = false
	get_tree().reload_current_scene()


func _on_button_home_pressed() -> void:
	allbutone_slot_reset(0)
	get_tree().paused = false
	global.speed = 1
	global.sun_value = 100
	global.sun_value_deficit = 0
	global.sun_value_surplus = 0
	global.danger_level = 0
	global.slime_count = 0
	global.you_lost = false
	get_tree().change_scene_to_file("res://scenes/home_screen.tscn")
