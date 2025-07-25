extends WeaponComponent

@export var arrow: PackedScene


func attack(target: HitboxComponent, team: int):
    var arrow_instance: Projectile = arrow.instantiate()

    arrow_instance.global_transform.origin = global_transform.origin
    arrow_instance.look_at(target.global_transform.origin)

    arrow_instance.team = team

    var root = get_tree().get_root()
    root.add_child(arrow_instance)
