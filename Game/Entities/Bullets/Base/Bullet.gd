class_name Bullet extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("players")

@onready var hitbox: Hitbox = $Hitbox
@onready var screen_notifier = $ScreenNotifier

@export_enum("Right", "Left", "Down", "Up", "Follower") var direction

@export var speed: float = 1.0
var dir_vector: Vector2 = Vector2.ZERO

var is_dying: bool = false

func _ready() -> void:
	hitbox.hit_hurtbox.connect(func(hurtbox: Hurtbox):
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
		_:
			print("direction not set")


func _physics_process(delta: float) -> void:
	velocity = dir_vector * speed
	var collision = move_and_collide(velocity)
	
	if collision:
		is_dying = true
		queue_free()


func _on_screen_notifier_screen_exited():
	set_process(false)
	hide()
