extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var hog_hit_range = $hog_hit_range
@onready var health_bar = $health_bar/TextureProgressBar
@onready var hitbox_collision = $hitbox/CollisionShape2D
var state = 0

var last_state = 0
var dead = false
var found_enemy = false

func _ready():
	health_bar.value = 200
	_animated_sprite.play("idle")

func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	
	if health_bar.value <= 0 and not dead:
		dead = true
		_on_death()
	
	if not dead:
		found_enemy = false
		for area in hog_hit_range.get_overlapping_areas():
			if area.name == "enemy" or area.name == "enemy_fly":
				found_enemy = true
			if found_enemy and _animated_sprite.animation != "attack":
				_animated_sprite.play("attack")
		
		if found_enemy:
			if _animated_sprite.animation != "attack":
				_animated_sprite.play("attack")
		else:
			if _animated_sprite.animation != "idle":
				_animated_sprite.play("idle")

func _on_death():
	# Nonaktifkan hitbox dan area serangan
	hitbox_collision.disabled = true
	hog_hit_range.get_node("CollisionShape2D").disabled = true
	
	# Sembunyikan karakter
	_animated_sprite.visible = false

func _on_animated_sprite_2d_frame_changed():
	if not dead:
		for i in range(5):
			var ball = load("res://scenes/attack_area.tscn").instantiate()
			ball.get_node("attack_area").name = "attack_area_hog"
			ball.position += Vector2(8, -7)
			ball.scale.x = 2.4
			add_child(ball)

func _on_hog_hit_range_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.

func _on_hitbox_area_entered(area):
	if area.name == "attack_area_enemy" and not dead:
		health_bar.value -= 1
