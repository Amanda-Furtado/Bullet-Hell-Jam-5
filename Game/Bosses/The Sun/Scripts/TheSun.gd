extends CharacterBody2D

signal start_phase2

#OUTSIDE
@onready var player = get_tree().get_first_node_in_group("players")
var on_phase2: bool = false
var og_health: int
#DAMAGE CONTROL
@onready var stats = $Stats
@onready var fire_sprite = $FireSprite
@onready var face_sprite = $FaceSprite
@onready var pashe_2_turn_timer = $Pashe2TurnTimer

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
##USAR O CAN SHOOT NO PATH PRA CONCERTAR OS BUGS EY B AGUENTO MAIS SOCRRO
var can_shoot: bool = true
var number_of_shoots: int = 12

#MOVEMENT
var rotate_way: float = 0.01
var is_health_mid: bool = false
var is_mid: bool = false

func _ready() -> void:
	og_health = stats.health
	
	get_parent().in_right.connect(func():
		if on_phase2:
			return
		rotate_way = 0.01
		zig_zag_shoot()
		)
	
	get_parent().in_mid.connect(func():
		if is_health_mid:
			on_phase2 = true
			start_phase2.emit()
			return
		rotate_way = 0
		straight_shoot()
		)
	
	get_parent().in_left.connect(func():
		if on_phase2:
			return
		rotate_way = -0.01
		zig_zag_shoot()
		)
	
	stats.health_changed.connect(func():
		if on_phase2:
			return
		if stats.health <= og_health/2:
			rotate_way = 0.01
			on_phase2 = true
			is_health_mid = true
			#boss_sprites.play("phase2")
			)
	
	start_phase2.connect(func():
		pashe_2_turn_timer.start()
			)


func _physics_process(delta: float) -> void:
	fire_sprite.rotate(rotate_way)


func line_shoot() -> void:
	if can_shoot:
		can_shoot = false
		for i in bullet_count:
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			
			if bullet_count == 1:
				# new_bullet.rotation = global_rotation -> reto sempre
				new_bullet.rotation = face_sprite.global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					# global_rotation + -> reto sempre
					face_sprite.global_rotation +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1 / fire_rate).timeout
		can_shoot = true


func curve_shoot() -> void:
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
		await line_shoot() 
		counter += 1


func zig_zag_shoot() -> void:
	var counter = 0
	while counter < number_of_shoots:
		await curve_shoot() 
		counter += 1


func _on_pashe_2_turn_timer_timeout():
	rotate_way *= -1
	await curve_shoot()
	pashe_2_turn_timer.start(randf_range(0.05, 0.2))
