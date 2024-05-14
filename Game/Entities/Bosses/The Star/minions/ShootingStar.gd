extends CharacterBody2D


signal top_touched
signal bot_touched

@onready var shooting_signal = $ShootingSignal
@onready var shooting_signal_animation = $ShootingSignalAnimation

@export var desired_speed: float = 2.0
@export var dir_vector: Vector2 = Vector2.UP
@onready var speed: float = 0.0

@onready var is_on_top: bool = false
@onready var is_on_bot: bool = false


func _ready() -> void:
	speed = desired_speed
	top_touched.connect(on_top)
	
	bot_touched.connect(on_bot)


func _physics_process(delta: float) -> void:
	if global_position.y <= 0 and !is_on_top:
			top_touched.emit()
	if global_position.y >= 320 and !is_on_bot:
			bot_touched.emit()
	
	position += dir_vector * speed
	move_and_slide()


func on_top() -> void:
	is_on_top = true
	is_on_bot = false
	
	speed = 0.0
	
	shooting_signal_animation.play("top_signal")
	await shooting_signal_animation.animation_finished
	shooting_signal_animation.play("top_trail")
	speed = desired_speed
	dir_vector = Vector2.DOWN


func on_bot() -> void:
	is_on_top = false
	is_on_bot = true
	
	speed = 0.0
	
	shooting_signal_animation.play("down_signal")
	await shooting_signal_animation.animation_finished
	shooting_signal_animation.play("bot_trail")
	speed = desired_speed
	dir_vector = Vector2.UP
