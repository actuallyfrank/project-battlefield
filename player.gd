extends Area2D
signal hit(body: Node2D)

@export var speed = 400;
var screen_size;

const inputs = {
	left = "move_left",
	right = "move_right",
	up = "move_up",
	down = "move_down"
}

func _ready():
	screen_size = get_viewport_rect().size;

func start(pos: Vector2):
	position = pos;
	show();

func _process(delta):
	var velocity = calculate_velocity()
	position = calculate_position(position, velocity, delta);
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



func calculate_position(current_position: Vector2, velocity: Vector2, delta: float) -> Vector2:
	var pos: Vector2 = Vector2.ZERO; 
	pos =  current_position + velocity.normalized() * speed * delta;
	return pos.clamp(Vector2.ZERO, screen_size);

func calculate_velocity() -> Vector2:
	var velocity = Vector2();
	if Input.is_action_pressed(inputs.right):
		velocity.x += 1;
	if Input.is_action_pressed(inputs.left):
		velocity.x -= 1;
	if Input.is_action_pressed(inputs.down):
		velocity.y += 1;
	if Input.is_action_pressed(inputs.up):
		velocity.y -= 1;
	return velocity.normalized() * speed;

func _on_body_entered(body: Node3D):
	hit.emit(body);
