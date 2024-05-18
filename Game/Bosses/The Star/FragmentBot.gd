extends Node2D


var dir_vector: Vector2 = Vector2.UP


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	look_at(dir_vector)
