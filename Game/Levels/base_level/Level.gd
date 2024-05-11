class_name Level extends Node2D


@onready var player = $Player
@onready var label = $CanvasLayer/Label


func _ready():
	pass


func _process(delta: float) -> void:
	label.text = str("FPS: ", Engine.get_frames_per_second())   
