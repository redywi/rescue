extends Node2D

@onready var animation_dead = $AnimatedSprite2D
@onready var dead_sound = $dead_sound

var timer = 0
var has_died = false

func _process(delta):
	animation_dead.speed_scale = 2 * global.speed
	animation_dead.play("dead")
	timer += delta
	if not dead_sound.playing :
		dead_sound.play()
		has_died = true
	
	if timer > 1:
		self.queue_free()
