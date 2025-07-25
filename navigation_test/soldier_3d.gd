extends CharacterBody3D
class_name Soldier3D

# Called when the node enters the scene tree for the first time.
func _ready():
    print("Soldier3D is ready")

func die():
    queue_free()
    print("Soldier3D has died")
