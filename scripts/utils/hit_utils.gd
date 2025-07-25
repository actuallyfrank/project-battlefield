class_name HitUtils

static func canHit(area: Area3D, team: int = -1) -> bool:
	var areaHitbox = getHitbox(area)
	if areaHitbox == null:
		return false

	var isSameTeam = getTeam(areaHitbox) == team
	if areaHitbox and !isSameTeam:
		return true
	return false

static func getHitbox(area: Area3D) -> HitboxComponent3D:
	if area is HitboxComponent3D:
		return area as HitboxComponent3D
	return null

static func getTeam(hitbox: HitboxComponent3D) -> int:
	if hitbox.teamComponent:
		return hitbox.teamComponent.team
	return -1
