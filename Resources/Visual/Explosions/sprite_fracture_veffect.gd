class_name SpriteFractureEffect extends GPUParticles2D

@onready var actor_sprite: Texture

func _ready() -> void:
	emitting = true
	#process_material.shader_parameter.sprite = actor_sprite
