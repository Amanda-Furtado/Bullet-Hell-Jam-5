extends CharacterBody2D


signal touch_top
signal touch_bot


@onready var player = get_tree().get_first_node_in_group("players")
@onready var boss_hurtbox = $bossHurtbox
@onready var boss_sprites = $bossSprites

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

func _ready() -> void:
	boss_hurtbox.hurt.connect(func(hitbox: Hitbox):
		flash_effect.flash()
		shake_effect.tween_shake()
		)


func _physics_process(delta: float) -> void:
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
