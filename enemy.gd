extends CharacterBody2D

@export var speed: float = 10
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(enemy_types[randi_range(0, enemy_types.size() - 1)])

func _physics_process(delta: float) -> void:
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()

func make_path_to_player() -> void:
	nav_agent.target_position = player.global_position
	# print("making path to player", player.global_position)

func _on_timer_timeout():
	make_path_to_player()
