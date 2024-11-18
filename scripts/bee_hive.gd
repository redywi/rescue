extends Node2D
@onready var _animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var sun_timer = $sun_timer
@onready var timer_bar = $timer_bar/TextureProgressBar
@onready var health_bar = $health_bar/TextureProgressBar
@onready var hitbox = $hitbox
@export var state = 2
var last_state = 2
var dead = false
var sun_time = false
var color_up = 200

func _ready():
	health_bar.value = 100
	health_bar.visible = false
	timer_bar.visible = false
	sun_timer.wait_time = 30
	sun_timer.start()
	_animated_sprite.play("idle")
	
func _physics_process(delta):
	
	_animated_sprite.speed_scale = 0.8 * global.speed
	if health_bar.value <= 0:
		dead = true
	
	timer_bar.value = int(sun_timer.time_left * (100 / 30.0))

	if sun_time and color_up <= 0:
		sun_time = false
		var sun_float = load("res://scenes/honey_float.tscn").instantiate()
		sun_float.position = self.position
		get_parent().add_child(sun_float)

	if sun_time:
		if self.modulate.r < 1.5:
			self.modulate += Color(0.01, 0.01, 0.01, 0) * global.speed
		color_up -= 5 * global.speed
	elif not sun_time and color_up < 200:
		self.modulate -= Color(0.01, 0.01, 0.01, 0) * global.speed
		color_up += 5 * global.speed

func _on_sun_timer_timeout():
	if not sun_time:
		sun_time = true
		var sun_instance = load("res://scenes/honey_float.tscn").instantiate()
		sun_instance.position = self.position
		get_parent().add_child(sun_instance)
		sun_timer.start()

func _on_hitbox_area_entered(area):
	if area.name == "attack_area_enemy":
			health_bar.value -= 1
