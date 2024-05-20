extends Control


@onready var button_audio = $ButtonAudio

@onready var master_audio_slider = $MarginContainer/HBoxContainer/AudioContainer/MasterAudioSlider
@export var main_menu = load("res://Game/User Interface/StartMenu.tscn")
@onready var return_game_button = %ReturnGameButton
@onready var return_menu_button = %ReturnMenuButton

func _ready() -> void:
	master_audio_slider.grab_focus()

func _on_sfx_audio_slider_drag_ended(value_changed):
	button_audio.play()


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		hide()
		await get_tree().create_timer(0.2).timeout
		get_tree().paused = false
		queue_free()


func _on_return_game_button_pressed():
	return_game_button.disabled = true
	return_menu_button.disabled = true
	hide()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	queue_free()


func _on_return_menu_button_pressed():
	get_tree().paused = false
	return_game_button.disabled = true
	return_menu_button.disabled = true
	SceneManager.load_new_scene(main_menu.resource_path)
