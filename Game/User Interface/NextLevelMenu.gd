extends Control

@onready var next_level_button = $NextLevelButton
@export var next_level_scene: PackedScene


func _ready() -> void:
	next_level_button.disabled = false
	next_level_scene = get_parent().get_parent().next_level


func _on_next_level_button_pressed():
	next_level_button.disabled = true
