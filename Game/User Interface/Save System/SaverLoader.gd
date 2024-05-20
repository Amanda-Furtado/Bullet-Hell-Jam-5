extends Node


@onready var player: Player = get_tree().get_first_node_in_group("players")
var level: Node2D


func save_game() -> void:
	var saved_game: SavedGame = SavedGame.new()
	
	saved_game.player_health = player.stats.health
	saved_game.player_position = player.global_position
	
	var saved_data: Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")


func load_game(level) -> void:
	var saved_game: SavedGame = load("user://savegame.tres") as SavedGame
	
	player.global_position = saved_game.player_position
	player.stats.health = saved_game.player_health
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		level.add_child(restored_node)
		
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)
