class_name ShakeEffect extends Node


@export var node_to_shake: Node2D
@export var shake_amount: float = 2.0
@export var shake_duration: float = 0.4

var shake: float = 0.0


func tween_shake() -> void:
	shake = shake_amount
	
	var tween = create_tween()
	
	tween.tween_property(self, "shake", 0.0, shake_duration).from_current()


func _physics_process(delta: float) -> void:
	node_to_shake.position = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
