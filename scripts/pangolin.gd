extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D

var pangolin_speed = 14
var speed_multiplier = 8
var move = 1
var state = 0
var last_state = 0
var dead = false
var pos

func _ready():
	_animated_sprite.play("attack")

func _physics_process(delta):
	_animated_sprite.speed_scale = 6 * global.speed
	
	self.position.x += global.speed * pangolin_speed * delta * speed_multiplier * move
	match move:
		0:
			pass
		1:
			_animated_sprite.play("attack")
	
	if self.position.x > 480:
		dead = true

func _on_animated_sprite_2d_frame_changed():
	for i in range(5):
		var ball = load("res://scenes/attack_area.tscn").instantiate()
		ball.get_node("attack_area").name = "attack_area_pangolin"
		ball.position += Vector2(9, 0)
		ball.scale.x = 2.4
		add_child(ball)
