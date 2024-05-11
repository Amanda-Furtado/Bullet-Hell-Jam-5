class_name FlashEffect extends Node


@export var flash_material: Resource
@export var sprite: CanvasItem
@export var flash_duration: float = 0.2

var original_sprite_material: Material

var timer: Timer = Timer.new()

func _ready() -> void:
	add_child(timer)
	
	original_sprite_material = sprite.material

func flash() -> void:
	sprite.material = flash_material
	
	timer.start(flash_duration)
	await timer.timeout
	
	sprite.material = original_sprite_material
