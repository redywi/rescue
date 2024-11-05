extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var vine_hit_range = $vine_hit_range
@onready var hitbox_collision = $hitbox/CollisionShape2D
@export var state = 0

var last_state = 0
var dead = false

func _ready():
	_animated_sprite.play("idle")

func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	
	hitbox_collision.disabled = true
		
func _on_animated_sprite_2d_frame_changed():
	for i in range(5):
		var ball = load("res://scenes/attack_area.tscn").instantiate()
		ball.get_node("attack_area").name = "attack_area_vine"
		ball.position += Vector2(0, -4)
		ball.scale.x = 2.4
		add_child(ball)

func _on_vine_hit_range_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass
