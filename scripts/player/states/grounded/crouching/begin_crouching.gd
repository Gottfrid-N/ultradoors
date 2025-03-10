extends PlayerState

func handle_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.move_camera_from_mouse(event)

	if event.is_action_released("crouch"):
		switch_state.emit(state_manager.states.STOP_CROUCHING, {})

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		switch_state.emit(state_manager.states.BEGIN_AIRBORNE_CROUCHING, {})

	var new_height = player.collision_shape.shape.height - player.crouching_speed * delta
	if new_height > player.crouched_collision_shape_height:
		player.position -= Vector3(0, player.crouching_speed * delta, 0)
		player.collision_shape.shape.height = new_height
		player.collision_shape.position += Vector3(0, player.crouching_speed * 0.5 * delta, 0)
	else:
		player.position -= Vector3(0, player.collision_shape.shape.height - player.crouched_collision_shape_height, 0)
		player.collision_shape.shape.height = player.crouched_collision_shape_height
		player.collision_shape.position = Vector3(0, 1 - (player.crouched_collision_shape_height / player.collision_shape_height), 0)
		switch_state.emit(state_manager.states.CROUCHING, {})

	player.apply_friction(delta)
	player.apply_acceleration(delta)

func enter(previous_state_name: StringName, data: Dictionary) -> void:
	player.base_acceleration = player.defualt_base_acceleration / 2

func exit(next_state_name: StringName) -> void:
	pass
