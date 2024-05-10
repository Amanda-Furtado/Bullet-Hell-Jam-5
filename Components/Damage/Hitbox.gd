class_name Hitbox extends Area2D


@export var damage: int = 1

signal hit_hurtbox(hurtbox)

func _ready():
	area_entered.connect(_on_hurtbox_entered)


func _on_hurtbox_entered(hurtbox: Hurtbox):
	if not hurtbox is Hurtbox:
		return
	if hurtbox.is_invincible: 
		return
	
	# Signal out that we hit a hurtbox (this is useful for destroying projectiles when they hit something)
	hit_hurtbox.emit(hurtbox)
	# Have the hurtbox signal out that it was hit
	hurtbox.hurt.emit(self)
