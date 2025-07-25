extends Area3D
class_name HitboxComponent3D

@export var teamComponent: TeamComponent
@export var health: HealthComponent

func hit(damage: int):
	health.hit(damage)
	print("HitboxComponent3D: Hit with damage: ", damage)
