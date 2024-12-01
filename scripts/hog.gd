extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var hog_hit_range = $hog_hit_range
@onready var health_bar = $health_bar/TextureProgressBar
@onready var hitbox_collision = $hitbox/CollisionShape2D
@onready var attack_sound = $attack_sound
@onready var enter_sound = $enter_sound

var state = 0
var last_state = 0
var found_enemy = false
var dead = false
var has_entered = false

func _ready():
	health_bar.visible = false
	health_bar.value = 150
	_animated_sprite.play("idle")

func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	
	if is_died(health_bar.value):
		dead = true
	
	if not dead:
		found_enemy = false
		for area in hog_hit_range.get_overlapping_areas():
			if area.name == "enemy" or area.name == "enemy_fly":
				found_enemy = true

		# Mengatur animasi dan suara berdasarkan keberadaan musuh
		if found_enemy:
			if _animated_sprite.animation != "attack":
				_animated_sprite.play("attack")
				if not attack_sound.playing:
					attack_sound.play()  # Mainkan suara jika belum diputar
		else:
			if _animated_sprite.animation != "idle":
				_animated_sprite.play("idle")
				if attack_sound.playing:
					attack_sound.stop()  # Hentikan suara saat tidak menyerang

func is_died(health):
	if health <= 0:
		dead = true
		hitbox_collision.disabled = true
		hog_hit_range.get_node("CollisionShape2D").disabled = true
		_animated_sprite.visible = false

func _on_animated_sprite_2d_frame_changed():
	if health_bar.value > 0:
		for i in range(5):
			var ball = load("res://scenes/attack_area.tscn").instantiate()
			ball.get_node("attack_area").name = "attack_area_hog"
			ball.position += Vector2(9, 0)
			ball.scale.x = 2.4
			add_child(ball)

func _on_hog_hit_range_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass

func _on_hitbox_area_entered(area):
	if not has_entered:
		enter_sound.play()
		has_entered = true
	if area.name == "attack_area_enemy" and not dead:
		health_bar.value -= 1
	if area.name == "projectile_area" and not dead:
		health_bar.value -= 10
	if area.name == "projectile_area2" and not dead:
		health_bar.value -= 8
	if area.name == "projectile_area3" and not dead:
		health_bar.value -= 20
