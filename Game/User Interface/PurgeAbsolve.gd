extends Control


@export var boss: CharacterBody2D
@export var player: CharacterBody2D

@onready var purge_button = %PurgeButton
@onready var absolve_button = %AbsolveButton


func disable_buttons():
	purge_button.disabled = true
	absolve_button.disabled = true


func _on_purge_button_pressed():
	disable_buttons()
	boss.purge()


func _on_absolve_button_pressed():
	disable_buttons()
	boss.absolve()
