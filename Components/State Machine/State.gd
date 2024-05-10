class_name State extends Node


#@export var animation_name: String

var parent: CharacterBody2D
var md: MovementData
var move_c: MoveControl


func enter() -> void:
	#animations.play(animation_name)
	pass


func exit() -> void:
	pass


func process_input(_event: InputEvent) -> State:
	return null


func process_frame(_delta: float) -> State:
	return null


func process_physics(_delta: float) -> State:
	return null


func get_direction() -> Vector2:
	return move_c.direction()
