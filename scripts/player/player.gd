class_name Player extends CharacterBody3D

@export var speed := 0.0


@export var defualt_base_acceleration := 42
@export var defualt_acceleration_modifier := 1.0
@export var air_acceleration_modifier := 0.5
@export var base_acceleration := defualt_base_acceleration:
	set(value):
		base_acceleration = value
		redefine_acceleration()
@export var acceleration_modifier := defualt_acceleration_modifier:
	set(value):
		acceleration_modifier = value
		redefine_acceleration()
# DO NOT SET VALUE
@export var acceleration = base_acceleration * acceleration_modifier
@export var max_acceleration_velocity = 10

func redefine_acceleration():
	acceleration = base_acceleration * acceleration_modifier

@export var defualt_crouching_speed = 7
@export var crouching_speed = defualt_crouching_speed

@export var defualt_friction = 4.0
@export var friction = defualt_friction

@export var acceleration_direction := Vector3(0, 0, 0)
@export var input_direction := Vector2(0, 0)

@export var mouse_sensitivity = 0.1
@export var defualt_mouse_sensitivity = 0.1

@onready var collision_shape: CollisionShape3D
@export var collision_shape_height := 2.0
@export var crouched_collision_shape_height := 1

@onready var space := get_world_3d().direct_space_state

## In RADIANS! x is vertical rotation, y is horizontal rotation and z is tilt
@export var euler: = Vector3(0, 0, 0)
@export var facing := Vector3(0, 0, 0)
@export var facingh := Vector3(0, 0, 0)
@export var facingh2d := Vector2(0, 0)
@export var velocityh := Vector3(0, 0, 0)
@export var velocityh2d := Vector2(0, 0)

func _ready() -> void:
	collision_shape = $"CollisionShape3D"

func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	$HorizontalPivot.global_transform.basis = Basis.from_euler(Vector3(0, euler.y, 0))
	$Camera.global_transform.basis = Basis.from_euler(euler)

	facing = Vector3(-sin(euler.y), euler.x, -cos(euler.y))
	var facinge = Vector3(euler)
	facingh = Vector3(facing.x, 0, facing.z)
	facingh2d = Vector2(facingh.x, facingh.z)

	velocityh = Vector3(velocity.x, 0, velocity.z)
	velocityh2d = Vector2(velocity.x, velocity.z)

	speed = velocity.length()

	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	acceleration_direction = $HorizontalPivot.basis * Vector3(input_direction.x, 0, input_direction.y)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_mouse_capture"):
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func move_camera_from_mouse(event: InputEventMouseMotion):
	var changeh = -event.relative.x*mouse_sensitivity
	var changev = -event.relative.y*mouse_sensitivity

	if euler.y + changeh > -360 and euler.y + changeh < 360:
		euler.y += deg_to_rad(changeh)	
	else:
		euler.y = fmod(euler.y + deg_to_rad(changeh), 360.0)

	if euler.x + changev > -90 and euler.x + changev < 90:
		euler.x += deg_to_rad(changev)
	else:
		euler.x = roundf(euler.x)

func apply_friction(delta: float):
	if speed != 0:
		var drop = speed * friction * delta
		velocity *= max(speed - drop, 0) / speed

func apply_gravity(delta: float):
	velocity.y += get_gravity().y * delta 

func apply_acceleration(delta: float):
	var acceleration_velocity = acceleration * delta
	var projection = velocity.dot(acceleration_direction)

	if projection + acceleration_velocity > max_acceleration_velocity:
		acceleration_velocity = max_acceleration_velocity - projection

	velocity += acceleration_velocity * acceleration_direction
