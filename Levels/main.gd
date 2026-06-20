extends Node2D

func _physics_process(delta: float) -> void:
	if $Player.move_and_slide():
		for i in $Player.get_slide_collision_count():
			var col = $Player.get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				col.get_collider().apply_force(col.get_normal() * -($Player.direction.length() * 100.0))
