extends CharacterBody2D


#nodes
@onready var player = get_tree().get_first_node_in_group("players")
@onready var sprite = $Sprite
@onready var atk_timer = $AtkTimer
@onready var lil_star_spawner = $lilStarSpawner
@onready var marker = $Marker

#damage
@onready var stats = $lilStarStats
@onready var hurtbox = $lilStarHurtbox
#effect
@onready var shake_effect = $ShakeEffect
@onready var flash_effect = $FlashEffect
@onready var scale_effect = $ScaleEffect
#testing
@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0.0
@export_range(0, 20) var fire_rate: float = 2.0
@export var barrel_origin: Node2D

var can_shoot: bool = true


func _ready() -> void:
	hurtbox.hurt.connect(func(hitbox: Hitbox):
		flash_effect.flash()
		shake_effect.tween_shake()
		scale_effect.tween_scale()
		)
	stats.no_health.connect(func():
		atk_timer.stop()
		)


func _process(delta: float) -> void:
	look_at(player.global_position)


func _physics_process(delta: float) -> void:
	shoot()


func shoot() -> void:
	if can_shoot:
		can_shoot = false
		for i in bullet_count:
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			
			if bullet_count == 1:
				new_bullet.rotation = global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					global_rotation +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1 / fire_rate).timeout
		can_shoot = true
