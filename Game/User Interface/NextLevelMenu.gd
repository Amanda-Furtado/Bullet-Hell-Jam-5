extends Control

@onready var next_level_button = $NextLevelButton
@onready var next_level_scene: PackedScene
@onready var sound_effect = $SoundEffect


func _ready() -> void:
	
	next_level_button.disabled = false
	next_level_scene = get_parent().get_parent().next_level


func _on_next_level_button_pressed():
	EventsManager.destroy_all_bullets.emit()
	next_level_button.disabled = true
	SceneManager.load_new_scene(next_level_scene.resource_path)
