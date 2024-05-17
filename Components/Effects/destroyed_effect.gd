class_name DestroyedEffect extends Node


@export var actor: Node2D
@export var stats: Node
@export var dest_ef_spawner: Spawner


func _ready() -> void:
	stats.no_health.connect(destroy)


func destroy() -> void:
	dest_ef_spawner.spawn(actor.global_position)
	actor.queue_free()
