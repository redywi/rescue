extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var health_bar = $health_bar/TextureProgressBar
@onready var hitbox_collision = $hitbox/CollisionShape2D
@onready var enter_sound = $enter_sound
@onready var dead_sound = $dead_sound

var state = 0
var last_state = 0
var dead = false
var has_entered = false
var has_dead = false

func _ready():
	health_bar.visible = false
	health_bar.value = 600
	_animated_sprite.play("idle")
	enter_sound.play()
	has_entered = true

func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	
	if is_died(health_bar.value):
		dead = true
	
func is_died(health):
	if health <= 0:
		dead = true
		hitbox_collision.disabled = true
		_animated_sprite.visible = false

func _on_hitbox_area_entered(area):
	if area.name == "attack_area_enemy" and not dead:
		health_bar.value -= 1
