extends Node2D
@onready var _animated_sprite = $AnimatedSprite2D

@onready var vine_hit_range = $vine_hit_range
@onready var hitbox_collision = $hitbox/CollisionShape2D

@export var state = 0
var last_state = 0
var dead = false
var power_up = 0
var particle = preload("res://scenes/particles_square.tscn")

func _ready():
	pass

func particle_effect(amount, ini_min, ini_max, gravity_y, z_in, color):
	var particleee = particle.instantiate()
	particleee.position.y += 6
	particleee.get_child(0).color = color
	add_child(particleee)
	particleee.get_child(0).amount = amount
	particleee.get_child(0).emitting = true
	particleee.get_child(0).initial_velocity_min = ini_min
	particleee.get_child(0).initial_velocity_max = ini_max
	particleee.get_child(0).gravity.y = gravity_y
	particleee.get_child(0).z_index = z_in

func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	if last_state == state:
		pass
	elif state == 0:
		last_state = state
		_animated_sprite.stop()
		_animated_sprite.play("seed")
		particle_effect(4, 9, 12, 10, 10, Color(1, 0.37, 0.37, 1))
	elif state == 1:
		last_state = state
		_animated_sprite.stop()
		_animated_sprite.play("idle")
		state += 1
		particle_effect(7, 22, 30, 20, 10, Color(1, 0.37, 0.37, 1))
	elif state == 2:
		last_state = state
		_animated_sprite.stop()
		_animated_sprite.play("idle")
		particle_effect(10, 40, 55, 30, -7, Color(1, 0.37, 0.37, 1))
	elif state > 2:
		last_state = state
		power_up += 15
	elif delta < 0:
		pass
	

	
	
	hitbox_collision.disabled = true
	
	if power_up > 0:
		_animated_sprite.play("power_up")
	elif power_up == 0 and state > 2:
		state = 2
		_animated_sprite.play("idle")
		return

func _on_timer_timeout():
	if state == 1:
		state += 1

func _on_animated_sprite_2d_frame_changed():
	for i in range(5):
		var ball = load("res://scenes/attack_area.tscn").instantiate()
		ball.get_node("attack_area").name = "attack_area_vine"
		ball.position += Vector2(0, -4)
		ball.scale.x = 2.4
		add_child(ball)
	if power_up > 0:
		particle_effect(1, 40, 55, 30, -7, Color(1, 0.37, 0.37, 1))
		power_up -= 1

func _on_time_up_timeout():
	dead = true



func _on_vine_hit_range_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
