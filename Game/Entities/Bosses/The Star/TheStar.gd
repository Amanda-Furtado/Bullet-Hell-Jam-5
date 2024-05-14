extends CharacterBody2D

@onready var stats = $Stats
@onready var diagonal = $Diagonal
@onready var vertical = $Vertical
@onready var atk_cooldown_timer = $AtkCooldownTimer
@onready var atk_timer = $AtkTimer


func _physics_process(delta: float) -> void:
	diagonal.rotate(0.01)
	vertical.rotate(-0.01)


func _on_atk_cooldown_timer_timeout():
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
