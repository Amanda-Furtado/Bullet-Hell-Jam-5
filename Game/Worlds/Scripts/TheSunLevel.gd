extends Node2D


@onready var player = $Player
#boss related
@onready var boss = $Path2D/PathFollow2D/TheSun
#Interface
@onready var label = $CanvasLayer/Label
@onready var hud = $CanvasLayer/Hud

func _ready():
	player.stats.health_changed.connect(func():
		hud.update_health_bar(player.stats.health))
	
	boss.stats.health_changed.connect(func():
		hud.update_boss_health_bar(boss.stats.health))
	
	boss.stats.no_health.connect(func():
		pass
		)


func _process(_delta: float) -> void:
	label.text = str("FPS: ", Engine.get_frames_per_second())   
