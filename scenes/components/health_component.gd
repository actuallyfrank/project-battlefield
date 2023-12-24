extends Node2D

class_name HealthComponent

@export var max_health = 100
var health = max_health

func _ready () -> void:
	health = max_health
	

func hit (damage: int) -> void:
	health -= damage

	print("health: ", health)

	if health <= 0:
		get_parent().queue_free()
