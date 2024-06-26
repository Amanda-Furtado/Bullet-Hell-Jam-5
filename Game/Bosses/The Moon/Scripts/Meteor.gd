extends CharacterBody2D


#nodes
@onready var boss = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("players")
@onready var sprite = $Sprite
@onready var marker = $Marker
@onready var atk_timer = $AtkTimer

#damage
@onready var stats = $Stats
@onready var hurtbox = $Hurtbox
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

@export var can_shoot: bool = true
#teste 2
var up_diag: float = 30
var down_diag: float = -30
var diag: float = 0.0

func _ready() -> void:
	
	diag = up_diag
	hurtbox.hurt.connect(func(hitbox: Hitbox):
		flash_effect.flash()
		shake_effect.tween_shake()
		)
	stats.no_health.connect(func():
		atk_timer.stop()
		)
	
	get_parent().get_parent().get_parent().point_touch.connect(func():
		shoot())
	
	#boss.touch_top.connect(func():
		#diag = up_diag)
	#
	#boss.touch_bot.connect(func():
		#diag = down_diag)


func _process(delta: float) -> void:
	if player != null:
		sprite.look_at(player.global_position)


#func shoot(diag) -> void:
	#if can_shoot:
		#can_shoot = false
		#for i in bullet_count:
			#var new_bullet = bullet.instantiate()
			#new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			#new_bullet.rotation = deg_to_rad(diag)
			#
			#get_tree().root.call_deferred("add_child", new_bullet)
		#await get_tree().create_timer(1 / fire_rate).timeout
		#can_shoot = true


#func shoot2() -> void:
	#if can_shoot:
		#can_shoot = false
		#for i in bullet_count:
			#var new_bullet = bullet.instantiate()
			#new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			#
			#if bullet_count == 1:
				#new_bullet.rotation = deg_to_rad(down_diag)
			#else:
				#var arc_rad = deg_to_rad(arc)
				#var increment = arc_rad / (bullet_count - 1)
				#new_bullet.global_rotation = (
					#deg_to_rad(down_diag) +
					#increment * i -
					#arc_rad / 2
				#)
			#get_tree().root.call_deferred("add_child", new_bullet)
		#await get_tree().create_timer(1 / fire_rate).timeout
		#can_shoot = true


func shoot() -> void:
	if can_shoot:
		scale_effect.tween_scale()
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
