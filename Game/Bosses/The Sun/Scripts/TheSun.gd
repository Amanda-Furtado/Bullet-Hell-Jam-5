extends CharacterBody2D


#OUTSIDE
@onready var player = get_tree().get_first_node_in_group("players")

#DAMAGE CONTROL
@onready var stats = $Stats
@onready var fire_sprite = $FireSprite

#EFFECTS
@onready var destroyed_effect = $DestroyedEffect
@onready var shake_effect = $ShakeEffect
@onready var flash_effect = $FlashEffect
@onready var scale_effect = $ScaleEffect

#BULLETs
@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0.0
@export_range(0, 20) var fire_rate: float = 2.0
@export var barrel_origin: Node2D

var can_shoot: bool = true
var number_of_shoots: int = 12

#MOVEMENT
var rotate_way: float = 0.01


func _ready() -> void:
	get_parent().in_right.connect(func():
		rotate_way = 0.01
		straight_shoot()
		)
	get_parent().in_mid.connect(func():
		rotate_way = 0
		straight_shoot()
		)
	get_parent().in_left.connect(func():
		rotate_way = -0.01
		straight_shoot()
		)


func _process(delta: float) -> void:
	#round_shoot()
	pass


func _physics_process(delta: float) -> void:
	fire_sprite.rotate(rotate_way)


func shoot() -> void:
	if can_shoot:
		can_shoot = false
		for i in bullet_count:
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			
			if bullet_count == 1:
				# new_bullet.rotation = global_rotation -> reto sempre
				new_bullet.rotation = fire_sprite.global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					# global_rotation + -> reto sempre
					fire_sprite.global_rotation +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1 / fire_rate).timeout
		can_shoot = true


func straight_shoot() -> void:
	var counter = 0
	while counter < number_of_shoots:
		await shoot() 
		counter += 1


func zig_zag_shoot() -> void:
	var counter = 0
	while counter < number_of_shoots:
		await shoot() 
		counter += 1
