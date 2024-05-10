class_name Moving extends State


@export var idle_state: State


func process_physics(_delta: float) -> State:
	parent.velocity = get_direction() * md.speed
	parent.move_and_slide()
	
	if get_direction() == Vector2.ZERO:
		return idle_state
	return null
