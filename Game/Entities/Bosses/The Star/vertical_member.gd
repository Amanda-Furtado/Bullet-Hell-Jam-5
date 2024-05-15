extends Node2D

signal got_hitted

#BULLET
@export var bullet: PackedScene
@onready var bullet_marker = $BulletMarker

#DAMAGE CONTROL
@onready var stats = $Stats

#EFFECTS
@onready var shake_effect = $ShakeEffect
@onready var flash_effect = $FlashEffect
@onready var scale_effect = $ScaleEffect
@onready var destroyed_effect = $DestroyedEffect


func _ready() -> void:
	stats.health_changed.connect(func():
		got_hitted.emit()
		shake_effect.tween_shake()
		flash_effect.flash())
	
	stats.no_health.connect(func():
		destroyed_effect.destroy())


func shoot() -> void:
	scale_effect.tween_scale()
	
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	
	new_bullet.global_position = bullet_marker.global_position
	new_bullet.rotation = global_rotation
