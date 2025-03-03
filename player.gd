extends CharacterBody3D

var speed = 0

var accel = 50
var fric = 4
var air_accel = 50
var air_fric = 0.01

var accel_direction := Vector3(0, 0, 0)
var input_direction := Vector2(0, 0)

var mouse_sens = 0.4

var space: PhysicsDirectSpaceState3D

var angleh := 0.0
var anglev := 0.0
var facing := Vector3(0, 0, 0)
var facingh := Vector3(0, 0, 0)
var facingh2d := Vector2(0, 0)
var velocityh := Vector3(0, 0, 0)
var velocityh2d := Vector2(0, 0)

@onready var explosion_preload = preload("res://explosion.tscn")

func cast_ray_from_camera():
	var query = PhysicsRayQueryParameters3D.create(global_position, )
	return space.intersect_ray(query)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var changeh = -event.relative.x*mouse_sens
		var changev = -event.relative.y*mouse_sens

		if angleh + changeh > -360 and angleh + changeh < 360:
			angleh += changeh	
		else:
			angleh = fmod(angleh + changeh, 360.0)

		if anglev + changev > -90 and anglev + changev < 90:
			anglev += changev
		else:
			anglev = roundf(anglev)
	
	if event.is_action_pressed("jump") and is_on_floor():
		velocity += Vector3(0, 5, 0)

	if event.is_action_pressed("toggle_mouse_capture"):
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event.is_action_pressed("shoot"):
		$Pivot/Camera.

func _physics_process(delta: float) -> void:
	space = get_world_3d().direct_space_state

	$HorizontalPivot.global_transform.basis = Basis.from_euler(Vector3(0, deg_to_rad(angleh), 0))
	$Pivot.global_transform.basis = Basis.from_euler(Vector3(deg_to_rad(anglev), deg_to_rad(angleh), 0))

	facing = Vector3(-sin(deg_to_rad(angleh)), deg_to_rad(anglev), -cos(deg_to_rad(angleh)))
	facingh = Vector3(-sin(deg_to_rad(angleh)), 0, -cos(deg_to_rad(angleh)))
	facingh2d = Vector2(facingh.x, facingh.z)

	velocityh = Vector3(velocity.x, 0, velocity.z)
	velocityh2d = Vector2(velocity.x, velocity.z)

	speed = velocity.length()

	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	accel_direction = $HorizontalPivot.basis * Vector3(input_direction.x, 0, input_direction.y)

	if is_on_floor():
		# friction
		if speed != 0:
			var drop = speed * fric * delta
			velocity *= max(speed - drop, 0) / speed

		# accel
		velocity += accel_direction * accel * delta
	else:
		# grav
		velocity.y += get_gravity().y * delta 

		# accel
		velocity += accel_direction * air_accel * delta

	move_and_slide()
