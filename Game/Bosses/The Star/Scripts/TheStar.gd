extends CharacterBody2D

signal start_phase2

@onready var stats = $Stats

@onready var diagonal = $Diagonal
@onready var vertical = $Vertical
@onready var atk_cooldown_timer = $AtkCooldownTimer
@onready var atk_timer = $AtkTimer

@onready var rotate_incr: float = 0.0

var og_health: int
var on_phase2: bool = false

func _ready() -> void:
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
	
	stats.health_changed.connect(func():
		if on_phase2:
			return
		if stats.health <= og_health/2:
			on_phase2 = true
			start_phase2.emit()
		)

func health_manager() -> void:
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
