class_name Hurt extends Node


@export var stats: Node
@export var hurtbox: Hurtbox

func _ready() -> void:
	hurtbox.hurt.connect(func(hitbox: Hitbox):
		stats.health -= hitbox.damage
	)
