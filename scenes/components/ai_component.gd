extends Node2D
class_name AIComponent

@export var speed: float = 10
@export var actor: CharacterBody2D
@export var teamComponent: TeamComponent
@export var weaponComponent: WeaponComponent

enum State { IDLE, CHASING, ATTACKING }
var state: State = State.IDLE

var target: HitboxComponent = null
var actorsInRange: Array[HitboxComponent] = []

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta: float) -> void:
	if state != State.CHASING:
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()

	actor.velocity = current_agent_position.direction_to(next_path_position) * speed
	actor.move_and_slide()

func _process(_delta: float) -> void:
	updateState()



func updateState() -> void:
	if canAttack():
		state = State.ATTACKING
		return

	if target == null:
		state = State.IDLE
		return

	state = State.CHASING

func canAttack() -> bool:
	if target == null or weaponComponent == null:
		return false

	return weaponComponent.isTargetInReach(target)
	
	

func make_path_to_target() -> void:
	nav_agent.target_position = target.global_position

func _on_timer_timeout():
	if (target == null):
		return

	make_path_to_target()

func isCurrentTarget(area: Area2D) -> bool:
	if target == null:
		return false
	return target == area

func resetTarget() -> void:
	target = null
	nav_agent.target_position = global_position

	if actorsInRange.size() > 0:
		target = actorsInRange[0]

func sort(a: HitboxComponent, b: HitboxComponent) -> bool:
	if a == null or b == null:
		return false

	if global_position.distance_to(a.global_position) > global_position.distance_to(b.global_position):
		return false
	return true

func _on_detection_zone_area_entered(area:Area2D):
	if !HitUtils.canHit(area, teamComponent.team):
		return

	if actorsInRange.find(area) == -1:
		actorsInRange.append(area)

	if target == null:
		target = actorsInRange[0]


func _on_detection_zone_area_exited(area: Area2D):
	if !HitUtils.canHit(area, teamComponent.team):
		return
	
	if actorsInRange.find(area) == -1:
		return
	
	actorsInRange.erase(area)

	if isCurrentTarget(area):
		resetTarget()


func _on_target_timer_timeout():
	actorsInRange = DistanceUtils.sortByDistance(global_position, actorsInRange) 
	target = actorsInRange[0]