extends CharacterBody2D


@onready var player = get_tree().get_first_node_in_group("players")

func _physics_process(delta):
	#look_at(player.global_position)
	rotate_toward(randi_range(0, 180))
	move_and_slide()




func _on_rotation_timer_timeout() -> void:
	rotate(randi_range(0, 180))
