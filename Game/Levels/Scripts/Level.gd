class_name Level extends Node2D


@onready var player: Player = $Player
@onready var hud = $CanvasLayer/Hud
@export var boss: Node2D
@export var label: Label

func _ready():
	player.stats.health_changed.connect(func():
		hud.update_health_bar(player.stats.health))
	
	boss.stats.health_changed.connect(func():
		hud.update_boss_health_bar(boss.stats.health))
	
	boss.stats.no_health.connect(func():
		print("victory"))


func _process(delta: float) -> void:
	label.text = str("FPS: ", Engine.get_frames_per_second())   
