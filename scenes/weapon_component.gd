extends Node2D

class_name WeaponComponent

@export var reach: float = 30 
@export var ai: AIComponent = null
@export var team: TeamComponent = null
@export var cooldown: float = 1
var timer: float = 0

func attack(target: HitboxComponent, team: int):
	target.hit(10)

func isTargetInReach(target: HitboxComponent):
	var target_position = target.global_position
	var distance = global_position.distance_to(target_position)

	return distance <= reach

func _process(delta):
	if ai == null or team == null:
		return
	
	var target = ai.target

	if target == null:
		timer = 0
		return
	
	timer += delta

	if !isTargetInReach(target):
		return

	if timer >= cooldown:
		attack(target, team.team)
		timer = 0
