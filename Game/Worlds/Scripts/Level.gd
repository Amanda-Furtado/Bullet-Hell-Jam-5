class_name Level extends Node2D

@export var boss: CharacterBody2D

@onready var player: Player = $Player
@onready var hud = $CanvasLayer/Hud
@onready var label = $CanvasLayer/Label


func _ready() -> void:
	#Interface
	player.stats.health_changed.connect(func():
		hud.update_health_bar(player.stats.health))
	
	boss.stats.health_changed.connect(func():
		hud.update_boss_health_bar(boss.stats.health))
	
	#Scene Change
	boss.stats.no_health.connect(func():
		await get_tree().create_timer(2.0).timeout
		#get_tree().change_scene_to_packed(n_lvl)
		pass
		)
	

func _process(_delta: float) -> void:
	label.text = str("FPS: ", Engine.get_frames_per_second())   
