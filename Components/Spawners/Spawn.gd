class_name Spawner extends Node2D


@export var scene: PackedScene
@export var ray_cast: RayCast2D

func spawn(global_spawn_position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node:
	assert(scene is PackedScene, "Error: The scene export was never set on this spawner.")
	
	var instance = scene.instantiate()
	
	parent.add_child(instance)
	# Update the global position of the instance.
	# (This must be done after adding it as a child)
	
	instance.global_position = global_spawn_position
	# Return the instance in case we want to perform any other operations
	# on it after instancing it.
	return instance


func spawn_follower(global_spawn_position: Vector2 = global_position, parent: Node = get_tree().current_scene, ray_cast: RayCast2D = ray_cast) -> Node:
	assert(scene is PackedScene, "Error: The scene export was never set on this spawner.")
	
	var instance = scene.instantiate()
	
	parent.add_child(instance)
	
	instance.global_position = global_spawn_position
	instance.dir_vector = (ray_cast.target_position).normalized()
	
	return instance
