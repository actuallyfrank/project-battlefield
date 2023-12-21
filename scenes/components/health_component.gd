extends Node2D

class_name HealthComponent

@export var MaxHealth = 100
var Health = MaxHealth

func hit (damage: int) -> void:
    Health -= damage

    print("Health: ", Health)
