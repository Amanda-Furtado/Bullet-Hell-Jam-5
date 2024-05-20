class_name Level extends Node2D

@export var boss: CharacterBody2D
@export var next_level: PackedScene

@onready var player = $Player

@onready var hud: HUD = $CanvasLayer/Hud


func _ready() -> void:
	#Interface
	hud.boss_health_bar.max_value = boss.stats.health
	hud.boss_health_bar.value = boss.stats.health
	
	
	player.stats.health_changed.connect(func():
		hud.update_health_bar(player.stats.health))
	
	boss.stats.health_changed.connect(func():
		hud.update_boss_health_bar(boss.stats.health))
	
	#Scene Change
	boss.stats.no_health.connect(func():
		await get_tree().create_timer(2.0).timeout
		SceneManager.load_new_scene(next_level.resource_path)
		)
