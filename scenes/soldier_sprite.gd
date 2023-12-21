extends AnimatedSprite2D

@export var team: TeamComponent

func _ready():
	update_team()

func update_team() -> void:
	if team.team == 0:
		self_modulate = Color(1, 0, 0, 1)
	elif team.team == 1:
		self_modulate = Color(0, 0, 1, 1)
	elif team.team == 2:
		self_modulate = Color(0, 1, 0, 1)	

