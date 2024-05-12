extends CharacterBody2D


signal touch_top
signal touch_bot


@onready var player = get_tree().get_first_node_in_group("players")
@onready var boss_hurtbox = $bossHurtbox
@onready var boss_sprites = $bossSprites
@onready var stats = $Stats

#visual ef
@onready var shake_effect = $ShakeEffect
@onready var flash_effect = $FlashEffect
@onready var scale_effect = $ScaleEffect
#movement
@export var moon_speed: Vector2 = Vector2(0.0, 2.0)
@export var max_y: int = 0
@export var min_y: int = 288
var moon_dir: Vector2 = Vector2.UP
var rotation_speed: float = 2.0

#testing
@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0.0
@export_range(0, 20) var fire_rate: float = 2.0
@export var barrel_origin: Node2D

var can_shoot: bool = false


func _ready() -> void:
	boss_hurtbox.hurt.connect(func(hitbox: Hitbox):
		flash_effect.flash()
		shake_effect.tween_shake()
		)
	


func _physics_process(delta: float) -> void:
	shoot()
	boss_sprites.look_at(player.global_position)
	#rotate_to_target(player, delta)
	if global_position.y <= max_y:
		moon_dir = Vector2.DOWN
		touch_top.emit()
	
	elif global_position.y >= min_y:
		moon_dir = Vector2.UP
		touch_bot.emit()
	
	velocity = moon_speed * moon_dir
	move_and_slide()


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
