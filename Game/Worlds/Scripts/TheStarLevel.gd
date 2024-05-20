extends Level


@onready var top_star_fragment = $TopStarFragment
@onready var bot_star_fragment = $BotStarFragment
@onready var stars = $Stars


func _ready() -> void:
	super()
	RenderingServer.set_default_clear_color(Color.MIDNIGHT_BLUE)
	
	top_star_fragment.set_process(false)
	bot_star_fragment.set_process(false)
	
	boss.start_phase2.connect(func():
		phase2())


func phase2() -> void:
	stars.position.x = 64
	top_star_fragment.set_process(true)
	top_star_fragment.show()
	bot_star_fragment.set_process(true)
	bot_star_fragment.show()
