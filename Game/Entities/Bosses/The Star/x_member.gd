extends Sprite2D

@onready var spawner = $Spawner
@export var bullet: PackedScene
@onready var bullet_marker = $BulletMarker

func shoot() -> void:
	var bullet = bullet.instantiate()
	
	add_child(bullet)
	
	bullet.global_position = bullet_marker.global_position
	bullet.rotation = global_rotation
