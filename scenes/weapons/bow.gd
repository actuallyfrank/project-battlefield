extends WeaponComponent

@export var arrow: PackedScene

var arrowScene: Resource = load("res://scenes/weapons/arrow.tscn")

func attack(target: HitboxComponent, team: int):
    var arrow_instance: Projectile = arrowScene.instantiate()

    arrow_instance.global_transform.origin = global_transform.origin
    arrow_instance.look_at(target.global_transform.origin)

    arrow_instance.team = team

    var root = get_tree().get_root()
    root.add_child(arrow_instance)
