extends Node2D


var rotation_incr: float = 0.01

#BULLETs
@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0.0
@export_range(0, 20) var fire_rate: float = 2.0
@export var barrel_origin: Node2D

var can_shoot: bool = false
var number_of_shoots: int = 12


func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	can_shoot = true 


func _process(delta: float) -> void:
	rotate(rotation_incr)
	shoot()


func _on_reverter_timer_timeout():
	rotation_incr *= -1


func shoot() -> void:
	if can_shoot:
		can_shoot = false
		for i in bullet_count:
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			
			if bullet_count == 1:
				# new_bullet.rotation = global_rotation -> reto sempre
				new_bullet.rotation = global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					# global_rotation + -> reto sempre
					global_rotation +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1 / fire_rate).timeout
		can_shoot = true

