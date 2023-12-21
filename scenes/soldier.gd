extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(enemy_types[randi_range(0, enemy_types.size() - 1)])
