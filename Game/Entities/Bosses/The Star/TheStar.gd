extends CharacterBody2D

@onready var stats = $Stats
@onready var total_health: int = 0


@onready var diagonal = $Diagonal
@onready var vertical = $Vertical
@onready var atk_cooldown_timer = $AtkCooldownTimer
@onready var atk_timer = $AtkTimer


func _ready() -> void:
	for child in vertical.get_children():
		child.stats.health_changed.connect(update_total_health)
	for child in diagonal.get_children():
		child.stats.health_changed.connect(update_total_health)


func _physics_process(_delta: float) -> void:
	diagonal.rotate(0.01)
	vertical.rotate(-0.01)


func _on_atk_cooldown_timer_timeout() -> void:
	atk_timer.start()
	var counter = 0
	while counter < 10:
		await atk_timer.timeout
		for child in vertical.get_children():
			child.shoot()
		for child in diagonal.get_children():
			child.shoot()
			pass
		counter += 1
		atk_timer.start()
	atk_cooldown_timer.start()


func update_total_health() -> void:
	total_health = 0
	for child in vertical.get_children():
		total_health += child.stats.health
	for child in diagonal.get_children():
		total_health += child.stats.health
	stats.health = total_health
