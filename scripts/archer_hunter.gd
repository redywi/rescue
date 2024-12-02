extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var health_bar = $health_bar/TextureProgressBar
@onready var collision = $enemy/CollisionShape2D
@onready var bullet_sound = $bullet_sound
@onready var shoot_range = $shoot_range

var archer_speed = 4
var speed_multiplier = 2
var move = 1
var found_enemy = false
var archer_dead = preload("res://scenes/archer_dead.tscn")

func _ready():
	health_bar.visible = false
	health_bar.value = 100
	_animated_sprite.play("walk")

func _physics_process(delta):
	_animated_sprite.speed_scale = 1 * global.speed
	
	is_died(health_bar.value)
	
	if global.you_won == true:
		health_bar.value -= 999
	
	self.position.x -= global.speed * archer_speed * delta * speed_multiplier * move
	match move:
		0:
			pass
		1:
			_animated_sprite.play("walk")
			
	found_enemy = false
	for area in shoot_range.get_overlapping_areas():
		if area.name == "hitbox":
			found_enemy = true
		if found_enemy and _animated_sprite.animation != "attack":
			_animated_sprite.play("attack")
			
	if found_enemy:
		if _animated_sprite.animation != "attack":
			_animated_sprite.play("attack")
			move = 0
			archer_speed = 0
			speed_multiplier = 0
	else:
		if _animated_sprite.animation != "walk":
			_animated_sprite.play("walk")
			move = 1
			archer_speed = 4
			speed_multiplier = 2
			
	get_node("enemy/CollisionShape2D").disabled = health_bar.value <= 0
	get_node("shoot_range/CollisionShape2D").disabled = health_bar.value <= 0

func _on_animated_sprite_2d_animation_looped():
	if _animated_sprite.animation == "attack":
		var projectile = load("res://scenes/projectile.tscn").instantiate()
		projectile.position = self.position + Vector2(8, -8)
		projectile.scale /= 2
		get_parent().add_child(projectile)

func _on_animated_sprite_2d_frame_changed() -> void:
	if speed_multiplier < 8:
		speed_multiplier *= 2
	else:
		speed_multiplier = 1

func _on_enemy_area_entered(area: Area2D) -> void:
	if area.name == "bullet_area":
		health_bar.value -= 10
		bullet_sound.play()
	if area.name == "bullet_area2":
		health_bar.value -= 8
	if area.name == "bullet_area3":
		health_bar.value -= 20
	if area.name == "attack_area" or area.name == "attack_area_hog":
		health_bar.value -= 1.6
	if area.name == "explode_area" or area.name == "explode_area_bomb":
		health_bar.value -= 100
	if area.name == "attack_area" or area.name == "attack_area_pangolin":
		health_bar.value -= 100

func _on_enemy_area_exited(area: Area2D) -> void:
	if area.name == "hitbox" and move == 0:
		_animated_sprite.play("walk")
		move = 1
	
func is_died(health):
	if health <= 0:
		global.danger_level += 1
		global.slime_count += 1
		var dead_anim = archer_dead.instantiate()
		dead_anim.position = self.position + get_node("enemy").position
		get_parent().add_child(dead_anim)
		self.queue_free()


func _on_shoot_range_area_entered(area: Area2D) -> void:
	if area.name == "hitbox" and move == 1:
		_animated_sprite.play("attack")
		move = 0
		archer_speed = 0
		speed_multiplier = 0
