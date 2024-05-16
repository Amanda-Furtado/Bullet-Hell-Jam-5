class_name LoadingScreen extends CanvasLayer


signal transition_in_complete

@onready var progress_bar = %ProgressBar
@onready var transitions = %Transitions
@onready var timer = $Timer

var starting_animation_name: String


func _ready() -> void:
	progress_bar.hide()


func start_transition(animation_name: String) -> void:
	if !transitions.has_animation(animation_name):
		push_warning("'%s' animation does not exist: " % animation_name)
		animation_name = "fade_to_black"
	starting_animation_name = animation_name
	transitions.play(animation_name)
	
	timer.start()


func finish_transition() -> void:
	if timer:
		timer.stop()
	
	var ending_animation_name: String = starting_animation_name.replace("to", "from")
	
	if !transitions.has_animation(ending_animation_name):
		push_warning("'%s' animation does not exist: " % ending_animation_name)
		ending_animation_name = "fade_from_black"
	
	transitions.play(ending_animation_name)
	await transitions.animation_finished
	queue_free()


func report_midpoint() -> void:
	transition_in_complete.emit()


func update_bar(value: float) -> void:
	progress_bar.value = value


func _on_timer_timeout() -> void:
	progress_bar.show()
