class_name Player extends CharacterBody2D


@export var movement_data: MovementData

@onready var movement_state_machine = $MovementStateMachine
@onready var move_control = $MoveControl
@onready var stats = $Stats
@onready var weapon = $Weapon


func _ready() -> void:
	movement_state_machine.init(self, move_control, movement_data)


func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)


func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
	weapon.shoot()
