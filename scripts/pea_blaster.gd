extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var timer_bar = $timer_bar/TextureProgressBar
@onready var health_bar = $health_bar/TextureProgressBar
@onready var shoot_range = $shoot_range
@onready var hitbox = $hitbox
@onready var enter_sound = $enter_sound

var dead = false
var found_enemy = false
var state: int = 0
var last_state: int = 0
var has_entered = false

func _ready():
	health_bar.visible = false
	timer_bar.visible = false
	health_bar.value = 100
	_animated_sprite.play("idle")
	enter_sound.play()
	has_entered = true

func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	if health_bar.value <= 0:
		dead = true

	found_enemy = false
	for area in shoot_range.get_overlapping_areas():
		if area.name == "enemy":
			found_enemy = true
		if found_enemy and _animated_sprite.animation != "action":
			_animated_sprite.play("action")
			
	if found_enemy:
		if _animated_sprite.animation != "action":
			_animated_sprite.play("action")
	else:
		if _animated_sprite.animation != "idle":
			_animated_sprite.play("idle")
	
	get_node("hitbox/CollisionShape2D").disabled = health_bar.value <= 0
	get_node("shoot_range/CollisionShape2D").disabled = health_bar.value <= 0
	
func _on_animated_sprite_2d_animation_looped():
	if _animated_sprite.animation == "action":
		var bullet = load("res://scenes/pea_bullet.tscn").instantiate()
		bullet.position = self.position + Vector2(8, -7)
		bullet.scale /= 2
		get_parent().add_child(bullet)

func _on_hitbox_area_entered(area):
	if area.name == "attack_area_enemy" and not dead:
		health_bar.value -= 1
	if area.name == "projectile_area" and not dead:
		health_bar.value -= 10
	if area.name == "projectile_area2" and not dead:
		health_bar.value -= 8
	if area.name == "projectile_area3" and not dead:
		health_bar.value -= 20
