extends Area2D
class_name Projectile

@export var speed: int = 1000
@export var damage: int = 10
@export var max_distance: int = 1000
@export var team: int = -1

var start_position: Vector2

func _ready():
	start_position = global_position

func _physics_process(delta):
	var direction = global_rotation
	position += Vector2(cos(direction), sin(direction)) * speed * delta

	if start_position.distance_to(global_position) > max_distance:
		print("Projectile reached max distance")
		queue_free() 

func _on_area_entered(area:Area2D):
	print("Projectile entered area", area.name)
	if !HitUtils.canHit(area, team):
		return	
	
	var hitbox = HitUtils.getHitbox(area)
	if !hitbox:
		return

	hitbox.hit(damage)