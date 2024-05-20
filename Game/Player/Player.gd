class_name Player extends CharacterBody2D


@export var movement_data: MovementData
@onready var shake_effect = $ShakeEffect
@onready var flash_effect = $FlashEffect
@onready var spawner = $Spawner

@onready var movement_state_machine = $MovementStateMachine
@onready var move_control = $MoveControl
@onready var stats = $Stats
@onready var weapon = $Weapon
@onready var hurtbox: Hurtbox = $Hurtbox


func _ready() -> void:
	show()
	
	hurtbox.hurt.connect(func(hitbox: Hitbox):
		flash_effect.flash()
		shake_effect.tween_shake()
		hurtbox.is_invincible = true
		await get_tree().create_timer(0.2).timeout
		hurtbox.is_invincible = false
	)
	
	stats.no_health.connect(func():
		await spawner.spawn()
		hide()
		EventsManager.destroy_all_bullets.emit()
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = true)
	
	movement_state_machine.init(self, move_control, movement_data)
	weapon.can_shoot = false
	await get_tree().create_timer(1.0).timeout
	weapon.can_shoot = true


func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)


func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
	weapon.shoot()
