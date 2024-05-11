extends CharacterBody2D


@onready var player = get_tree().get_first_node_in_group("players")

func _physics_process(delta):
	move_and_slide()
