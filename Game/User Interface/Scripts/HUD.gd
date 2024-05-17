class_name HUD extends Control

@onready var health_bar = %HealthBar
@onready var karma_bar = %KarmaBar
@onready var boss_health_bar = %BossHealthBar


func update_health_bar(new_value) -> void:
	health_bar.value = new_value


func update_boss_health_bar(new_value) -> void:
	boss_health_bar.value = new_value
