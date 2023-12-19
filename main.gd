extends Node

@export var mob_scene: PackedScene
var score = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over(body:Node2D):
	$ScoreTimer.stop();
	$EnemyTimer.stop();
	$StartTimer.start();
	$Player.die()
	print("Game Over");

func new_game():
	score = 0;
	$Player.start($StartPosition.position)
	$ScoreTimer.start();
	$EnemyTimer.start();
	$Player.show();

func _on_start_timer_timeout():
	new_game()


func _on_score_timer_timeout():
	score += 1
