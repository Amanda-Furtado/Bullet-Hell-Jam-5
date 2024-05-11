class_name Bullet extends CharacterBody2D


@export var speed: int = 2
var direction: Vector2 = Vector2.LEFT


func _ready():
	pass 


func _physics_process(delta: float) -> void:
	velocity = direction * speed
	
	var collision = move_and_collide(velocity)
	
	if collision:
		queue_free()
