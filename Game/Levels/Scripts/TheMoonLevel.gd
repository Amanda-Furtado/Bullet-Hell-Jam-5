extends Level


@onready var moon_sea = $MoonSea


func _ready() -> void:
	super()
	
	boss.touch_top.connect(func():
		moon_sea.pull_top_ocean())
	boss.touch_bot.connect(func():
		moon_sea.pull_bot_ocean())
