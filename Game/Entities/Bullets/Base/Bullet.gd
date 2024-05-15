class_name Bullet extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("players")

@onready var hitbox: Hitbox = $Hitbox
@onready var screen_notifier = $ScreenNotifier

@export var has_bullets: bool = false
#testing
@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0.0
@export_range(0, 20) var fire_rate: float = 2.0
@export var barrel_origin: Node2D

var can_shoot: bool = true

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
	
	if expire:
		await get_tree().create_timer(life_time).timeout
		if has_bullets:
			spawn_bullets()
		queue_free()

func _physics_process(_delta: float) -> void:
	velocity = dir_vector * speed
	move_and_collide(velocity)


func spawn_bullets():
	if can_shoot:
		can_shoot = false
		for i in bullet_count:
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			
			if bullet_count == 1:
				new_bullet.rotation = global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					global_rotation +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1 / fire_rate).timeout
		can_shoot = true


func _on_screen_notifier_screen_exited():
	set_process(false)
	hide()
	await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
	queue_free()
