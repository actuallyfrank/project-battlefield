extends Node2D

@export var team: int = 0
@export var distanceBetweenSoldiers: int = 10
@export var soldierOptions: Array[PackedScene] = []

@export var soldiers: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in soldiers.size():
		var unit = soldierOptions[soldiers[i]].instantiate()

		var teamComponent = unit.get_node("TeamComponent")

		print(teamComponent)

		teamComponent.team = team
		unit.position = Vector2(i * distanceBetweenSoldiers, 0)

		add_child(unit)


