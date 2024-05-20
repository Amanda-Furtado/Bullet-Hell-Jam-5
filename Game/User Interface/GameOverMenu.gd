extends Control

@onready var restart_button = %RestartButton
@onready var repeat_level_scene: PackedScene


func _ready() -> void:
	restart_button.disabled = false
	repeat_level_scene = get_parent().get_parent().same_level


func _on_restart_button_pressed() -> void:
	restart_button.disabled = true
