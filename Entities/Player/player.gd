extends CharacterBody2D

@export var SPEED = 300.0
@export var spin_speed := 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
		velocity.x -= direction.y * spin_speed / (5 * 1.5)
		velocity.y += direction.x * spin_speed / (4 * 1.5)
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.y = move_toward(velocity.y, 0.0, SPEED)
	rotation_degrees += spin_speed / 100
	move_and_slide()
