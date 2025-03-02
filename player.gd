extends CharacterBody3D

var accel = 50
var fric = 4
var air_accel = 50
var air_fric = 0.01

var mouse_sens = 0.4
var angleh := 0.0
var anglev := 0.0

var facing = Vector3(0, 0, 0)

var speed = 0

@onready var explosion_preload = preload("res://explosion.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var changeh = -event.relative.x*mouse_sens
		var changev = -event.relative.y*mouse_sens

		if angleh + changeh > -90 and angleh + changeh < 90:
			angleh += changeh	
		else:
			angleh = fmod(angleh + changeh, 360.0)

		if anglev + changev > -90 and anglev + changev < 90:
			anglev += changev
		else:
			anglev = roundf(anglev)
		
		global_basis = Basis.from_euler(Vector3(0, deg_to_rad(angleh), 0))
		$Camera.global_transform.basis = Basis.from_euler(Vector3(deg_to_rad(anglev), deg_to_rad(angleh), 0))
	
	if event.is_action_pressed("jump") and is_on_floor():
		velocity += Vector3(0, 5, 0)

	if event.is_action_pressed("toggle_mouse_capture"):
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("shoot"):
		var ray := RayCast3D.new(); add_child(ray)
		ray.target_position = facing*1000

		print("shooting at: " + str(ray.target_position))

		if ray.is_colliding():
			var collision := ray.get_collision_point()
			print("shoot collision: " + str(collision))

			var explosion: Node3D = explosion_preload.instantiate()
			get_tree().root.add_child(explosion)

			explosion.global_position = collision

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
