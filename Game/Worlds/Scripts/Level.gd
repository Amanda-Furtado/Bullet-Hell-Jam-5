class_name Level extends Node2D

@export var boss: CharacterBody2D
@export var next_level: PackedScene

@onready var player = $Player

@onready var hud: HUD = $CanvasLayer/Hud
@onready var game_over_menu = $CanvasLayer/GameOverMenu
@onready var next_level_menu = $CanvasLayer/NextLevelMenu


func _ready() -> void:
	#Interface
	hud.boss_health_bar.max_value = boss.stats.health
	hud.boss_health_bar.value = boss.stats.health
	
	
	player.stats.health_changed.connect(func():
		hud.update_health_bar(player.stats.health))
	
	boss.stats.health_changed.connect(func():
		hud.update_boss_health_bar(boss.stats.health))
	
	#Scene Change
	player.stats.no_health.connect(func():
		await get_tree().create_timer(1.0).timeout
		game_over_menu.show()
		)
	
	boss.stats.no_health.connect(func():
		await get_tree().create_timer(1.0).timeout
		next_level_menu.show()
		)
	
	get_tree().paused = false
