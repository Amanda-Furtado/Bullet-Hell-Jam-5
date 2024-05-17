extends PathFollow2D


signal point_touch

@onready var the_moon = $TheMoon

@onready var point_timer = $PointTimer
@export var point_interval: float = 2.0

@export var speed: float = 0.1

func _ready() -> void:
	the_moon.stats.no_health.connect(func():
		queue_free())
	point_touch.connect(func():
		point_timer.start(point_interval + 0.5)
		on_point_stop()
		)


func _process(delta: float) -> void:
	if snappedf(progress_ratio, 0.01) == 0.00:
		on_top_point()
		on_point_stop()
	if snappedf(progress_ratio, 0.01) == 0.25:
		on_point_stop()
	if snappedf(progress_ratio, 0.01) == 0.50:
		on_bot_point()
		on_point_stop()
	
	progress_ratio += speed * delta


func on_top_point() -> void:
	if point_timer.time_left == 0:
		the_moon.touch_top.emit()


func on_bot_point() -> void:
	if point_timer.time_left == 0:
		the_moon.touch_bot.emit()


func on_point_stop() -> void:
	if point_timer.time_left == 0:
		point_touch.emit()
		set_process(false)
		await get_tree().create_timer(point_interval).timeout
		set_process(true)
