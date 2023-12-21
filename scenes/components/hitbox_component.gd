extends Area2D
class_name HitboxComponent

@export var team: TeamComponent
@export var health: HealthComponent

func hit(damage: int):
	health.hit(damage)

