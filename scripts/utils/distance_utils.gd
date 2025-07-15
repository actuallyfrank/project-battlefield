class_name DistanceUtils

static func sortByDistance(currentPosition: Vector2, actors: Array) -> Array:
	if actors.size() == 0:
		return []
	
	var sortedActors: Array = actors

	var sortFunc = func(a: Node2D, b: Node2D) -> bool:
		return sort(a, b, currentPosition)

	sortedActors.sort_custom(sortFunc)
	return sortedActors


static func sort(a: Node2D, b: Node2D, currentPosition: Vector2) -> bool:
	if a == null or b == null:
		return false

	if currentPosition.distance_to(a.global_position) > currentPosition.distance_to(b.global_position):
		return false
	return true
