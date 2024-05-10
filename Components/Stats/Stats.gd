class_name Stats extends Node


signal health_changed()
signal no_health()


@export var health: int = 1:
	set(value):
		#if health - value < 0:
			#value = 0
			#no_health.emit()
			#health = value
			#return
		
		health = value
		
		health_changed.emit()
		
		if health == 0: no_health.emit()
