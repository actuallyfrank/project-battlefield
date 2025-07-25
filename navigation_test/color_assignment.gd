extends Node

@export var teamComponent: TeamComponent
@export var materialOptions: Array[Material] = []
@export var meshInstances: Array[MeshInstance3D] = []

func _ready() -> void:
    if teamComponent == null:
        print("ColorAssignment: No TeamComponent found, cannot assign colors.")
        return

    var team_index = teamComponent.team
    if team_index < 0 or team_index >= materialOptions.size():
        print("ColorAssignment: Invalid team index, cannot assign color.")
        return

    var material = materialOptions[team_index]
    for mesh_instance in meshInstances:
        mesh_instance.material_override = material
        print("ColorAssignment: Assigned material to ", mesh_instance.name)
