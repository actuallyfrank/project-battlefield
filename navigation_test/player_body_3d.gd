extends CharacterBody3D

var speed: float = 5.0

func _physics_process(delta):
    var input_vector = Vector3.ZERO
    input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vector.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

    # print("Input Vector: ", input_vector)
    input_vector = input_vector.normalized()
    velocity = input_vector * speed
    move_and_slide()
