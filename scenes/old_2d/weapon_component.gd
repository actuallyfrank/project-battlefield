extends Node2D

class_name WeaponComponent

@export var reach: float = 100
@export var ai: AIComponent = null
@export var team: TeamComponent = null
@export var cooldown: float = 1

@export var animation_curve: Curve
@export var animation_duration: float = 0.5
@export var animation_amplitude: Vector2 = Vector2(20, 0)

var timer: float = 0
var animation_timer: float = 0
var is_animating: bool = false
var start_position: Vector2
var rest_position: Vector2

func attack(target: HitboxComponent, _team: int):
	target.hit(10)
	trigger_animation()

func trigger_animation():
	if animation_curve == null:
		return
	
	is_animating = true
	animation_timer = 0
	start_position = position

func _ready():
	rest_position = position

func isTargetInReach(target: HitboxComponent):
	var target_position = target.global_position
	var distance = global_position.distance_to(target_position)

	return distance <= reach

func _process(delta):
	if ai == null or team == null:
		return

	handleAnimation(delta)
	
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


func handleAnimation(delta: float):
	if is_animating:
		animation_timer += delta
		var progress = animation_timer / animation_duration
		
		if progress >= 1.0:
			is_animating = false
			position = rest_position
		else:
			var curve_value = animation_curve.sample(progress)
			var offset = animation_amplitude * curve_value
			position = rest_position + offset