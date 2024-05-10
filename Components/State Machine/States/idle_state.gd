class_name Idle extends State


@export var moving_state: State


func enter() -> void:
	parent.velocity = Vector2.ZERO


func process_input(_event: InputEvent) -> State:
	if get_direction() != Vector2.ZERO:
		return moving_state
	return null
