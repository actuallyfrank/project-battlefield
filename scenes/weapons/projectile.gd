extends Area2D
class_name Projectile

@export var speed: int = 1000
@export var damage: int = 10
@export var max_distance: int = 1000
@export var team: int = -1

var start_position: Vector2
var didHit: bool = false

func _ready():
	start_position = global_position

func _physics_process(delta: float):
	if didHit:
		return

	move(speed, delta)

	if start_position.distance_to(global_position) > max_distance:
		print("Projectile reached max distance")
		queue_free() 

func move(distance: int, delta: float):
	var direction = global_rotation
	position += Vector2(cos(direction), sin(direction)) * speed * delta

func penetrate(area: Area2D):
	reparent(area)
	didHit = true

func _on_area_entered(area:Area2D):
	if didHit or !HitUtils.canHit(area, team):
		return	
	
	var hitbox = HitUtils.getHitbox(area)
	if !hitbox:
		return

	penetrate(area)

	hitbox.hit(damage)