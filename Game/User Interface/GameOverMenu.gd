extends Control

@onready var restart_button = %RestartButton
@export var repeat_level_path: String
@onready var sound_effect = $SoundEffect


func _ready() -> void:
	restart_button.disabled = false


func _on_restart_button_pressed() -> void:
	EventsManager.destroy_all_bullets.emit()
	restart_button.disabled = true
	get_tree().change_scene_to_file(repeat_level_path)	
	
