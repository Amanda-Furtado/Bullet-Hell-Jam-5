extends CharacterBody2D


signal top_touched
signal bot_touched


@onready var shooting_signal = $ShootingSignal
@onready var shooting_signal_animation = $ShootingSignalAnimation


@export var desired_speed: float = 2.0
@onready var dir_vector: Vector2 = Vector2.DOWN
var speed: float = 0.0

@onready var is_travelling: bool = false


func _ready() -> void:
	speed = desired_speed
	top_touched.connect(on_top)
	
	bot_touched.connect(on_bot)


func _physics_process(delta: float) -> void:
	if global_position.y >= 320:
			bot_touched.emit()
	if global_position.y <= -16:
			top_touched.emit()
	
	position += dir_vector * speed
	move_and_slide()


func on_top() -> void:
	print("on top")
	shooting_signal_animation.play("top_signal")
	await shooting_signal_animation.animation_finished
	shooting_signal_animation.play("top_trail")
	speed = desired_speed


func on_bot() -> void:
	print("on bot")
	shooting_signal_animation.play("down_signal")
	await shooting_signal_animation.animation_finished
	shooting_signal_animation.play("bot_trail")
	speed = desired_speed


func _on_cooldown_shooting_timeout():
	dir_vector *= -1
