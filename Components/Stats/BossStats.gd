class_name BossStats extends Node


signal health_changed()
signal mid_health()
signal no_health()

var was_emited: bool = false

@export var health: int = 1:
	set(value):
		
		health = value
		
		health_changed.emit()
		
		
		if health == 0: no_health.emit()

var og_health: int = health
