extends CharacterBody3D

var accel = 10
var fric = 4
var air_accel = 10
var air_fric = 1

var mouse_sens = 0.4
var angleh = 0
var anglev = 0

var facing = Vector3(0, 0, 0)

var speed = 0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var changeh = event.relative.x*mouse_sens
		angleh += changeh
		rotate(Vector3(0, -1, 0), deg_to_rad(changeh))

		var changev = event.relative.y*mouse_sens
		if anglev + changev > -90 and anglev + changev < 90:
			anglev += changev
			$Camera.rotate(Vector3(-1, 0, 0), deg_to_rad(changev))
	
	if event.is_action_pressed("jump") and is_on_floor():
		velocity += Vector3(0, 5, 0)

	if event.is_action_pressed("toggle_mouse_capture"):
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := transform.basis * Vector3(input_dir.x, 0, input_dir.y)

	facing = Vector3(cos(deg_to_rad(angleh)), deg_to_rad(anglev), sin(deg_to_rad(angleh)))

	speed = velocity.length()

	if is_on_floor():
		# friction
		if speed != 0:
			var drop = speed * fric * delta
			velocity *= max(speed - drop, 0) / speed

		# accel
		velocity += direction * accel * delta
	else:
		# grav
		velocity.y += get_gravity().y * delta 

		# accel
		velocity += direction * air_accel * delta

	move_and_slide()
