class_name HitUtils

static func canHit(area: Area2D, team: int = -1) -> bool:
	var areaHitbox = getHitbox(area)
	if areaHitbox == null:
		return false

	var isSameTeam = getTeam(areaHitbox) == team
	if areaHitbox and !isSameTeam:
		return true
	return false

static func getHitbox(area: Area2D) -> HitboxComponent:
	if area is HitboxComponent:
		return area as HitboxComponent
	return null

static func getTeam(hitbox: HitboxComponent) -> int:
	if hitbox.teamComponent:
		return hitbox.teamComponent.team
	return -1

