extends Level


@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var phase_1_music = $Phase1Music
@onready var phase_2_music = $Phase2Music


func _ready() -> void:
	super()
	phase_1_music.play()
	RenderingServer.set_default_clear_color(Color.CORNFLOWER_BLUE)
	boss.start_phase2.connect(func():
		phase_1_music.stop()
		phase_2_music.play()
		)
