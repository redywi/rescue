extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	# Pastikan animasi "idle" diputar ketika game dijalankan
	animated_sprite.play("idle")
