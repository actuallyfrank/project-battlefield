extends CharacterBody2D

@export var speed = 400;

const inputs = {
	left = "move_left",
	right = "move_right",
	up = "move_up",
	down = "move_down"
}

func start(pos: Vector2):
	position = pos;
	show();

func _physics_process(delta: float) -> void:
	velocity = calculate_velocity()
	move_and_slide();
	animate_walk(velocity);


func animate_walk(velocity: Vector2):
	var is_moving: bool = velocity.length() > 0;
	if !is_moving:
		$AnimatedSprite2D.stop();
		return;

	$AnimatedSprite2D.play();

	if abs(velocity.x) > 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false;

		$AnimatedSprite2D.flip_h = velocity.x < 0;
		return;

	if abs(velocity.y) > 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0;
		return;

func calculate_velocity() -> Vector2:
	var inputVelocity = Vector2();
	if Input.is_action_pressed(inputs.right):
		inputVelocity.x += 1;
	if Input.is_action_pressed(inputs.left):
		inputVelocity.x -= 1;
	if Input.is_action_pressed(inputs.down):
		inputVelocity.y += 1;
	if Input.is_action_pressed(inputs.up):
		inputVelocity.y -= 1;
	return inputVelocity.normalized() * speed;