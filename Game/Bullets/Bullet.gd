class_name Bullet extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("players")

@onready var hitbox: Hitbox = $Hitbox
@onready var screen_notifier = $ScreenNotifier

@export var turn_back: bool = false
@export var expire: bool = false
@export var life_time: float = 0.0

@export_enum("Right", "Left", "Down", "Up", "Follower", "Adpt") var direction

@export var speed: float = 1.0

var dir_vector: Vector2 = Vector2.ZERO

var is_dying: bool = false

func _ready() -> void:
	hitbox.hit_hurtbox.connect(func(_hurtbox: Hurtbox):
		is_dying = true
		queue_free())
	
	match direction:
		0:
			dir_vector = Vector2.RIGHT
		1:
			dir_vector = Vector2.LEFT
		2:
			dir_vector = Vector2.DOWN
		3:
			dir_vector = Vector2.UP
		4:
			dir_vector = Vector2.RIGHT.rotated(global_rotation)
		5:
			dir_vector = Vector2.LEFT.rotated(global_rotation)
		_:
			print("direction not set")
	
	await get_tree().create_timer(2.0).timeout
	#global_rotation = global_rotation
	
	if turn_back:
		await get_tree().create_timer(1.0).timeout
		dir_vector = Vector2.RIGHT.rotated(global_rotation)
	
	
	if expire:
		await get_tree().create_timer(life_time).timeout
		queue_free()


func _physics_process(_delta: float) -> void:
	velocity = dir_vector * speed
	
	move_and_collide(velocity)


func _on_screen_notifier_screen_exited():
	set_process(false)
	hide()
	await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
	queue_free()
