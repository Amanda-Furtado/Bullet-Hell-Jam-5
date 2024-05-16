extends Control


@onready var moon_scene: PackedScene = load("res://Game/Worlds/TheMoonLevel.tscn")
@onready var star_scene: PackedScene = load("res://Game/Worlds/TheStarLevel.tscn")
@onready var sun_scene: PackedScene = load("res://Game/Worlds/TheSunLevel.tscn")

@onready var moon_button = $VBoxContainer/MoonButton


func _ready() -> void:
	moon_button.grab_focus()


func _on_moon_button_pressed():
	SceneManager.load_new_scene(moon_scene.resource_path)


func _on_star_button_pressed():
	SceneManager.load_new_scene(star_scene.resource_path)


func _on_sun_button_pressed():
	SceneManager.load_new_scene(sun_scene.resource_path)
