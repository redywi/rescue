extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var health_bar = $health_bar/TextureProgressBar
@onready var collision = $enemy/CollisionShape2D

var slimespeed = 2
var speed_multiplier = 1
var move = 1
var particle = preload("res://scenes/particles_square.tscn")
var butcher_dead = preload("res://scenes/butcher_dead.tscn")

func _ready():
	health_bar.visible = false
	health_bar.value = 100
	_animated_sprite.play("walk")

func _physics_process(delta):
	_animated_sprite.speed_scale = 1 * global.speed
	
	is_died(health_bar.value)
	
	if global.you_won == true:
		health_bar.value -= 999
	
	self.position.x -= global.speed * slimespeed * delta * speed_multiplier * move
	match move:
		0:
			pass
		1:
			_animated_sprite.play("walk")

func _on_area_2d_area_entered(area):
	if area.name == "hitbox" and move == 1:
		_animated_sprite.play("eat")
		move = 0
	if area.name == "bullet_area":
		health_bar.value -= 10
	if area.name == "bullet_area2":
		health_bar.value -= 8
	if area.name == "bullet_area3":
		health_bar.value -= 20
	if area.name == "attack_area" or area.name == "attack_area_hog":
		health_bar.value -= 1.6
	if area.name == "explode_area" or area.name == "explode_area_bomb":
		health_bar.value -= 100

func _on_enemy_area_exited(area):
	if area.name == "hitbox" and move == 0:
		_animated_sprite.play("walk")
		move = 1

func _on_animated_sprite_2d_animation_looped():
	if _animated_sprite.animation == "eat":
		for i in range(20):
			var ball = load("res://scenes/bad_attack_area.tscn").instantiate()
			ball.position += Vector2(-2, 1)
			ball.scale.x = 2
			ball.scale.y = 2
			add_child(ball)
		for i in range(8):
			health_bar.value += 1

func _on_animated_sprite_2d_frame_changed():
	if speed_multiplier < 8:
		speed_multiplier *= 2
	else:
		speed_multiplier = 1
		
func is_died(health):
	if health <= 0:
		global.danger_level += 1
		global.slime_count += 1
		var dead_anim = butcher_dead.instantiate()
		dead_anim.position = self.position + get_node("enemy").position
		get_parent().add_child(dead_anim)
		self.queue_free()
