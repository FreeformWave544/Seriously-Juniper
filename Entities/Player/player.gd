extends CharacterBody2D
class_name Player

@export var SPEED = 300.0
@export var base_spin_speed := 300.0
@export var spin_speed := 300.0
@export var max_health := 100.0
@export var health := 100.0
const JUMP_VELOCITY = -400.0

@export var abilityList := {
	"Lazer": {
		"Rarity": "Common",
		"Func": lazer()
	}
}
var ability := ""
var direction := Vector2.ZERO
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction: velocity = direction * SPEED
		#velocity.x -= direction.y * spin_speed / (5 * 3.0)
		#velocity.y += direction.x * spin_speed / (4 * 3.0)
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.y = move_toward(velocity.y, 0.0, SPEED)
	rotation_degrees += spin_speed / 100.0 if (spin_speed / 100.0) <= 360.0 else spin_speed - 360.0 / 100.0
	if Input.is_action_just_pressed("ui_accept"): base_spin_speed *= 2.0
	modulate.b = health / max_health * (spin_speed / 200.0)
	modulate.g = health / max_health * (spin_speed / 200.0)
	if Input.is_action_just_pressed("AbilitySpin"):
		for i in range(50):
			rotation_degrees -= 10.0
			await get_tree().process_frame
		ability = abilityList.keys().pick_random()
		print(ability, " -=- ", abilityList[ability]["Func"])
	move_and_slide()

func damage(dmg) -> void:
	health -= dmg
	spin_speed = lerp(base_spin_speed, 0.0, 1.0 - health / max_health)
	if spin_speed <= 0.0: get_tree().reload_current_scene()

func lazer(time := 5.0):
	return time
