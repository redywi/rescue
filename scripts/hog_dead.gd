extends Node2D

@onready var animation_dead = $AnimatedSprite2D
var timer = 0

func _process(delta):
	animation_dead.speed_scale = 1 * global.speed
	animation_dead.play("dead")
	timer += delta
	
	if timer > 1:
		self.queue_free()
