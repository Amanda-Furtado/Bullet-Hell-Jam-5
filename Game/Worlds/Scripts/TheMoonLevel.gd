extends Level


#boss related
@onready var moon_sea = $MoonSea
@onready var moon_path_follow = $Path2D/MoonPathFollow

@onready var phase_1_music = $Phase1Music
@onready var phase_2_music = $Phase2Music


func _ready() -> void:
	super()
	
	
	RenderingServer.set_default_clear_color(Color.ROYAL_BLUE)
	#boss related
	
	phase_1_music.play()
	
	boss.phase2_in_course.connect(func():
		phase_1_music.stop()
		phase_2_music.play())
	
	boss.touch_top.connect(func():
		if boss.on_phase2:
			moon_sea.ocean_phase2()
			return
		else:
			moon_sea.pull_top_ocean()
		)
	boss.touch_bot.connect(func():
		if boss.on_phase2:
			moon_sea.ocean_phase2()
			return
		else:
			moon_sea.pull_bot_ocean()
		)
	moon_path_follow.point_touch.connect(func():
		if boss.on_phase2 == false:
			return
		boss.phase2_shoot())
