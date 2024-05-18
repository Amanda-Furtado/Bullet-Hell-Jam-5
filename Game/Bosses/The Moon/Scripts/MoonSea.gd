extends Node2D


@onready var top_ocean = $top_ocean
@onready var bot_ocean = $bot_ocean
@onready var top_spawner = $top_ocean/TopSpawner
@onready var bot_spawner = $bot_ocean/BotSpawner
@onready var audio = $Audio


func ocean_phase2():
	
	ocean_up(top_ocean, top_spawner)
	ocean_up(bot_ocean, bot_spawner)


func pull_top_ocean():
	ocean_up(top_ocean, top_spawner)
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	await get_tree().create_timer(2.0).timeout
	
	ocean_down(top_ocean)


func pull_bot_ocean():
	ocean_up(bot_ocean, bot_spawner)
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	await get_tree().create_timer(2.0).timeout
	
	ocean_down(bot_ocean)


func ocean_down(ocean):
	while ocean.position.x > 0:
		await get_tree().create_timer(0.05).timeout
		ocean.position.x -= 8


func ocean_up(ocean, spawner: Spawner):
	while ocean.position.x < 48:
		await get_tree().create_timer(0.05).timeout
		ocean.position.x += 8
	spawner.spawn()
