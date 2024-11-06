extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $area_triggered/CollisionShape2D
var exploded = false

func _ready():
	animated_sprite.play("idle")
	connect("area_entered", Callable(self, "_on_area_triggered_area_entered"))

func explode():
	if exploded:
		return
	exploded = true
	animated_sprite.play("explode")
	
	collision_shape.disabled = true
	
	await animated_sprite.finished
	queue_free()

func _on_area_triggered_area_entered(area: Area2D) -> void:
	if area.name == "slime":
		area.take_explode_damage(50)
		explode()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "slime":
		area.take_explode_damage(50)
		explode()
	elif area.name == "attack_area_enemy":
		explode()
