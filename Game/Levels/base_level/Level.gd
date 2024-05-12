class_name Level extends Node2D


@onready var player = $Player
@onready var label = $CanvasLayer/Label
@onready var moon_sea = $MoonSea
@onready var the_moon = $TheMoon


func _ready():
	the_moon.touch_top.connect(func():
		moon_sea.pull_top_ocean())
	the_moon.touch_bot.connect(func():
		moon_sea.pull_bot_ocean())
	#await get_tree().create_timer(3.0).timeout


func _process(delta: float) -> void:
	label.text = str("FPS: ", Engine.get_frames_per_second())   
