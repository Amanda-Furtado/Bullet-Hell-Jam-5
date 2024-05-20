extends PathFollow2D


signal in_right
signal in_mid
signal in_left

@onready var point_timer = $pointTimer
@onready var the_sun = $TheSun

@export var speed: float = 0.1

@export var right_interval: float = 2.0
@export var mid_interval: float = 3.0
@export var left_interval: float = 2.0


var initial_speed: float


func _ready() -> void:
	initial_speed = speed
	speed = 0
	
	in_right.connect(func():
		point_timer.start()
	)
	in_left.connect(func():
		point_timer.start()
	)
	in_mid.connect(func():
		point_timer.start(mid_interval + 0.5)
	)


func _process(delta: float) -> void:
	if the_sun != null:
		if progress_ratio == 0.0:
			right_point()
		
		if snappedf(progress_ratio, 0.01) == 0.50:
			if the_sun.on_phase2:
				in_mid.emit()
				set_process(false)
				return
			mid_point()
		
		if progress_ratio == 1.0:
			left_point()
		
		
		if the_sun.on_phase2:
			speed = 0.2
		
		progress_ratio += speed * delta


func right_point() -> void:
	if point_timer.time_left == 0:
		in_right.emit()
	await get_tree().create_timer(right_interval).timeout
	speed = initial_speed


func mid_point() -> void:
	if point_timer.time_left == 0:
		in_mid.emit()
		set_process(false)
		await get_tree().create_timer(mid_interval).timeout
		set_process(true)


func left_point() -> void:
	if point_timer.time_left == 0:
		in_left.emit()
	await get_tree().create_timer(left_interval).timeout
	speed = -initial_speed
