extends Node3D
class_name AIComponent3D

@export var speed: float = 10
@export var rotation_speed: float = 5.0
@export var actor: CharacterBody3D
@export var teamComponent: TeamComponent
@export var weaponComponent: WeaponComponent3D

enum State {IDLE, CHASING, ATTACKING}
var state: State = State.IDLE

var target: HitboxComponent3D = null
var actorsInRange: Array[HitboxComponent3D] = []

@onready var nav_agent := $NavigationAgent3D as NavigationAgent3D

func _physics_process(_delta: float) -> void:
	if state != State.CHASING:
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = nav_agent.get_next_path_position()

	var direction = (next_path_position - current_agent_position).normalized()
	actor.velocity = direction * speed
	actor.move_and_slide()

func _process(delta: float) -> void:
	updateState();
	
	if target != null:
		look_at_target(delta)

func updateState() -> void:
	if canAttack():
		if state != State.ATTACKING:
			print("AIComponent3D: Switching to ATTACKING state")
		state = State.ATTACKING
		return

	if target == null:
		if state != State.IDLE:
			print("AIComponent3D: No target, switching to IDLE state")
		state = State.IDLE
		return

	if state != State.CHASING:
		print("AIComponent3D: Target acquired, switching to CHASING state")
	state = State.CHASING

func canAttack() -> bool:
	if target == null or weaponComponent == null:
		return false

	var in_reach = weaponComponent.isTargetInReach(target)
	return in_reach

func make_path_to_target() -> void:
	# Convert target.global_position to Vector3 if it's Vector2
	var pos = target.global_position
	if typeof(pos) == TYPE_VECTOR2:
		pos = Vector3(pos.x, 0, pos.y)
	nav_agent.target_position = pos
	print("AIComponent3D: Making path to target at position: ", pos)

func _on_timer_timeout():
	if (target == null):
		return

	make_path_to_target()

func isCurrentTarget(area: Area3D) -> bool:
	if target == null:
		return false
	return target == area

func resetTarget() -> void:
	print("AIComponent3D: Resetting target.")
	target = null
	nav_agent.target_position = global_position
	if actorsInRange.size() > 0:
		print("AIComponent3D: New target set from actorsInRange.")
		target = actorsInRange[0]

func sort(a: HitboxComponent3D, b: HitboxComponent3D) -> bool:
	if a == null or b == null:
		return false
	var a_pos = a.global_position
	var b_pos = b.global_position
	if typeof(a_pos) == TYPE_VECTOR2:
		a_pos = Vector3(a_pos.x, 0, a_pos.y)
	if typeof(b_pos) == TYPE_VECTOR2:
		b_pos = Vector3(b_pos.x, 0, b_pos.y)
	if global_position.distance_to(a_pos) > global_position.distance_to(b_pos):
		return false
	return true

func _on_detection_zone_area_entered(area: Area3D):
	print("AIComponent3D: Area entered detection zone: ", area)
	if !HitUtils.canHit(area, teamComponent.team):
		print("AIComponent3D: Area cannot be hit by this team.")
		return
	if actorsInRange.find(area) == -1:
		actorsInRange.append(area)
		print("AIComponent3D: Area entered detection zone: ", area)
	if target == null:
		print("AIComponent3D: Setting new target from entered area.")
		target = actorsInRange[0]

func _on_detection_zone_area_exited(area: Area3D):
	# TODO: Update HitUtils.canHit for 3D or implement a 3D version
	# if !HitUtils.canHit(area, teamComponent.team):
	#        return
	if actorsInRange.find(area) == -1:
		return
	actorsInRange.erase(area)
	print("AIComponent3D: Area exited detection zone: ", area)
	if isCurrentTarget(area):
		print("AIComponent3D: Current target exited, resetting target.")
		resetTarget()
		
func _on_target_timer_timeout():
	# TODO: Update DistanceUtils.sortByDistance for 3D or implement a 3D version
	# actorsInRange = DistanceUtils.sortByDistance(global_position, actorsInRange)
	# Fallback: sort manually using the sort function
	print("AIComponent3D: Sorting actors in range by distance.")
	actorsInRange.sort_custom(Callable(self, "sort"))
	if actorsInRange.size() > 0:
		print("AIComponent3D: Timer timeout, new closest target: ", actorsInRange[0])
		target = actorsInRange[0]

func look_at_target(delta: float) -> void:
	if target == null or actor == null:
		return
	var t_pos = target.global_position
	var a_pos = actor.global_position
	if typeof(t_pos) == TYPE_VECTOR2:
		t_pos = Vector3(t_pos.x, 0, t_pos.y)
	if typeof(a_pos) == TYPE_VECTOR2:
		a_pos = Vector3(a_pos.x, 0, a_pos.y)
	var direction_to_target = t_pos - a_pos
	var target_rotation = atan2(direction_to_target.x, direction_to_target.z)
	actor.rotation.y = lerp_angle(actor.rotation.y, target_rotation, rotation_speed * delta)
