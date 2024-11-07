extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var hog_hit_range = $hog_hit_range
@onready var health_bar = $health_bar/TextureProgressBar
@onready var hitbox_collision = $hitbox/CollisionShape2D
var hog_dead = preload("res://scenes/hog_dead.tscn")
var state = 0
var last_state = 0
var found_enemy = false
var dead = false

func _ready():
	health_bar.visible = false
	health_bar.value = 150
	_animated_sprite.play("idle")

func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	
	is_died(health_bar.value, dead)
	
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

func is_died(health, dead:bool):
	if health <= 0:
		dead = true
		hitbox_collision.disabled = true
		hog_hit_range.get_node("CollisionShape2D").disabled = true
		_animated_sprite.visible = false
		
		var dead_anim = hog_dead.instantiate()
		dead_anim.position = self.position + get_node("hitbox").position
		get_parent().add_child(dead_anim)
		
		self.queue_free()
		
	return dead

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
	if area.name == "attack_area_enemy" and not dead:
		health_bar.value -= 10
