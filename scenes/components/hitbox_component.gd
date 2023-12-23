extends Area2D
class_name HitboxComponent

@export var teamComponent: TeamComponent
@export var health: HealthComponent

func hit(damage: int):
	health.hit(damage)

