extends CharacterBody2D

signal start_phase2


@onready var hurt_audio = $HurtAudio
@onready var destroyed_audio = $DestroyedAudio
@onready var shake_effect = $ShakeEffect
@onready var flash_effect = $FlashEffect


@onready var stats = $Stats
@onready var hurtbox = $Hurtbox

@onready var diagonal = $Diagonal
@onready var vertical = $Vertical
@onready var atk_cooldown_timer = $AtkCooldownTimer
@onready var atk_timer = $AtkTimer

@onready var rotate_incr: float = 0.0

var og_health: int
var on_phase2: bool = false

func _ready() -> void:
	
	hurtbox.hurt.connect(func(hitbox: Hitbox):
		hurt_audio.pitch_scale = randf_range(1.0, 1.2)
		hurt_audio.play()
		flash_effect.flash()
		shake_effect.tween_shake())
	
	og_health = stats.health
	for child in vertical.get_children():
		child.stats.no_health.connect(func():
			rotate_manager()
			health_manager()
			)
	for child in diagonal.get_children():
		child.stats.no_health.connect(func():
			rotate_manager()
			health_manager()
			)
	stats.no_health.connect(func():
		destroyed_audio.play()
		EventsManager.destroy_all_bullets.emit())
	
	stats.health_changed.connect(func():
		if on_phase2:
			return
		if stats.health <= og_health/2:
			on_phase2 = true
			start_phase2.emit()
		)

func health_manager() -> void:
	hurt_audio.pitch_scale = randf_range(1.0, 1.2)
	hurt_audio.play()
	flash_effect.flash()
	shake_effect.tween_shake()
	stats.health -= 5
	stats.health_changed.emit()


func _physics_process(_delta: float) -> void:
	diagonal.rotate(min(0.01 + rotate_incr, 0.02))
	vertical.rotate(max(-0.01 - rotate_incr, -0.02))


func _on_atk_cooldown_timer_timeout() -> void:
	atk_timer.start()
	var counter = 0
	while counter < 10:
		await atk_timer.timeout
		for child in vertical.get_children():
			child.shoot()
		for child in diagonal.get_children():
			child.shoot()
		counter += 1
		atk_timer.start()
	atk_cooldown_timer.start()


func rotate_manager() -> void:
	rotate_incr += 0.005
