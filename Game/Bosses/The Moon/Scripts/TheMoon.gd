extends CharacterBody2D


signal touch_top
signal touch_bot
signal phase2_in_course

@onready var player = get_tree().get_first_node_in_group("players")
@onready var boss_hurtbox = $bossHurtbox
@onready var boss_sprites = $bossSprites
@onready var stats = $Stats
#visual ef
@onready var shake_effect = $ShakeEffect
@onready var flash_effect = $FlashEffect
@onready var scale_effect = $ScaleEffect
@onready var audio_effect = $AudioEffect

#movement
var rotation_speed: float = 2.0
#phase2
@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0.0
@export_range(0, 20) var fire_rate: float = 2.0
@export var barrel_origin: Node2D

var can_shoot: bool = true
var on_phase2: bool = false


func _ready() -> void:
	var og_health = stats.health
	boss_hurtbox.hurt.connect(func(hitbox: Hitbox):
		flash_effect.flash()
		shake_effect.tween_shake()
		)
	
	stats.health_changed.connect(func():
		if on_phase2:
			return
		if stats.health <= og_health/2:
			phase2_in_course.emit()
			on_phase2 = true
			boss_sprites.play("phase2"))


func _physics_process(delta: float) -> void:
	if player != null:
		boss_sprites.look_at(player.global_position)


func phase2_shoot() -> void:
	shoot()


func shoot() -> void:
	if can_shoot:
		audio_effect.pitch_scale = randf_range(1.0, 1.2)
		audio_effect.play()
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
