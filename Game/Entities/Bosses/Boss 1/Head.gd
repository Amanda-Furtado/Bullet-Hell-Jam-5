extends CharacterBody2D


@onready var boss_stats = $BossStats
@onready var stats = $member1_spr/Stats
@onready var member_1_spr = $member1_spr


func _ready() -> void:
	boss_stats.health_changed.connect(func():
		print("boss hitted"))
	stats.no_health.connect(func():
		remove_child(member_1_spr))
