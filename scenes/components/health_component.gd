extends Node2D

class_name HealthComponent

@export var soldier: Soldier = null
@export var MaxHealth = 100
var Health = MaxHealth

func hit (damage: int) -> void:
    Health -= damage

    print("Health: ", Health)

    if Health <= 0:
        soldier.die()
