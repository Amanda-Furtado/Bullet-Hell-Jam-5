extends Node2D

@export var n_lvl: PackedScene
@onready var player = $Player
#boss related
@onready var boss = $TheMoon
@onready var moon_sea = $MoonSea
#Interface
@onready var label = $CanvasLayer/Label
@onready var hud = $CanvasLayer/Hud
@onready var debug_menu = $DebugMenu



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
	
	#boss related
	boss.touch_top.connect(func():
		moon_sea.pull_top_ocean())
	boss.touch_bot.connect(func():
		moon_sea.pull_bot_ocean())


func _process(_delta: float) -> void:
	label.text = str("FPS: ", Engine.get_frames_per_second())   
