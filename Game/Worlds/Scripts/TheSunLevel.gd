extends Level


@onready var path_follow_2d = $Path2D/PathFollow2D


func _ready() -> void:
	super()
	RenderingServer.set_default_clear_color(Color.CORNFLOWER_BLUE)
	
