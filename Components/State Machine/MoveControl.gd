class_name MoveControl extends Node


func direction() -> Vector2:
	return Input.get_vector("left_key", "right_key", "up_key", "down_key")
