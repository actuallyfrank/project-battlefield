extends Node2D

class_name WeaponComponent

@export var reach: float = 100 

func attack(target: HitboxComponent, team: int):
	print('ATTACK!')

	var target_position = target.global_position

	var distance = global_position.distance_to(target_position)

	if distance <= reach:
		target.hit(10)
