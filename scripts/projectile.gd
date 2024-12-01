extends Node2D

var projectile_speed = 150

func _physics_process(delta):
	self.position.x -= global.speed * projectile_speed * delta

func _on_projectile_area_area_entered(area):
	if area.name == "hitbox":
		var projectile_particle = load("res://scenes/projectile_particles_square.tscn").instantiate()
		get_parent().add_child(projectile_particle)
		projectile_particle.position = self.position
		projectile_particle.get_child(0).amount = 8
		projectile_particle.get_child(0).emitting = true
		projectile_particle.get_child(0).initial_velocity_min = 20
		projectile_particle.get_child(0).initial_velocity_max = 30
		projectile_particle.get_child(0).gravity.y = 20
		projectile_particle.get_child(0).z_index = 10
		projectile_particle.get_child(0).direction.x = -1
		projectile_particle.get_child(0).direction.y = -1
		self.queue_free()

func _on_timer_timeout():
	self.queue_free()
