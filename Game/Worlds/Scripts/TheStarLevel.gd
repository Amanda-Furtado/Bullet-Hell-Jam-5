extends Level


@onready var star1 = $ShootingStars
@onready var star2 = $ShootingStars2

@onready var fragment_top = $FragmentTop
@onready var fragment_bot = $FragmentBot


func _ready() -> void:
	super()
	RenderingServer.set_default_clear_color(Color.MIDNIGHT_BLUE)
	
	fragment_top.set_process(false)
	#fragment_bot.set_process(false)
	
	boss.start_phase2.connect(func():
		phase2())


func phase2() -> void:
	fragment_top.set_process(true)
	fragment_top.show()
	#fragment_bot.set_process(true)
	#fragment_bot.show()
	remove_child(star1)
	remove_child(star2)
