extends Level


#boss related
@onready var moon_sea = $MoonSea


func _ready() -> void:
	super()
	RenderingServer.set_default_clear_color(Color.ROYAL_BLUE)
	#boss related
	boss.touch_top.connect(func():
		if boss.on_phase2:
			return
		else:
			moon_sea.pull_top_ocean()
		)
	boss.touch_bot.connect(func():
		if boss.on_phase2:
			return
		else:
			moon_sea.pull_bot_ocean()
		)
