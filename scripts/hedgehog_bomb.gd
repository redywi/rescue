extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var area_triggered = $area_triggered
@onready var hitbox = $hitbox/CollisionShape2D
var dead = false
var state = 0
var last_state = 0

func _ready():
	_animated_sprite.play("idle")
	$area_triggered.connect("area_entered", Callable(self, "_on_area_triggered_area_entered"))
	
func _physics_process(delta):
	_animated_sprite.speed_scale = 0.8 * global.speed
	
	if dead == true:
		_on_death()
		
func _on_death():
	_animated_sprite.play("explode")
	hitbox.disabled = true
	explode()

func explode():
	var ball = load("res://scenes/explode_area.tscn").instantiate()
	ball.get_node("attack_area").name = "explode_area_bomb"
	ball.position += Vector2(8, -7)
	ball.scale.x = 2.4
	add_child(ball)
	
	dead = true

func _on_area_triggered_area_entered(area: Area2D) -> void:
	if area.name == "slime":
		explode()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "slime":
		explode()
	elif area.name == "attack_area_enemy":
		explode()
