extends Node2D
@export var speed: float = 10
@export var actor: CharacterBody2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(delta: float) -> void:
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()

	actor.velocity = current_agent_position.direction_to(next_path_position) * speed
	actor.move_and_slide()

func make_path_to_target() -> void:
	if actor.player == null:
		return

	nav_agent.target_position = actor.player.global_position

func _on_timer_timeout():
	make_path_to_target()
