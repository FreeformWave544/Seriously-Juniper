extends RigidBody2D

@export var damage := 1.0

func _physics_process(delta: float) -> void:
	if $Area2D.get_overlapping_bodies():
		for body in $Area2D.get_overlapping_bodies():
			if body is Player:
				body.damage(5.0 * damage * delta)
