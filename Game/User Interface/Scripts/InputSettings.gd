extends Control


@onready var input_button_scene = preload("res://Game/User Interface/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ActionList

var input_actions = {
	"left_key": "Move Left",
	"right_key": "Move Right",
	"up_key": "Move Up",
	"down_key": "Move Down",
}

var is_remapping: bool = false
var action_to_remap = null
var remapping_button = null


func _ready():
	_create_action_list()


func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))


func _on_input_button_pressed(button, action) -> void:
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		
		button.find_child("LabelInput").text = "Press key to bind..."


func _input(event) -> void:
	if is_remapping:
		if(
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()

func _update_action_list(button, event) -> void:
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")


func _on_reset_controls_pressed():
	_create_action_list()
