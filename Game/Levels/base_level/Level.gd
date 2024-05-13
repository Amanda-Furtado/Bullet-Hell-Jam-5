class_name Level extends Node2D


@onready var player: Player = $Player
@onready var label = $CanvasLayer/Label
@onready var moon_sea = $MoonSea
@onready var the_moon = $TheMoon
@onready var hud = $CanvasLayer/Hud
@onready var easter_egg = $CanvasLayer/easter_egg


func _ready():
	the_moon.touch_top.connect(func():
		moon_sea.pull_top_ocean())
	the_moon.touch_bot.connect(func():
		moon_sea.pull_bot_ocean())
	
	player.stats.health_changed.connect(func():
		hud.update_health_bar(player.stats.health))
	
	the_moon.stats.health_changed.connect(func():
		hud.update_boss_health_bar(the_moon.stats.health))
	
	the_moon.stats.no_health.connect(func():
		easter_egg.show())


func _process(delta: float) -> void:
	label.text = str("FPS: ", Engine.get_frames_per_second())   
