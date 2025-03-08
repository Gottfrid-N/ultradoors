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
	else:
		var new_height = player.collision_shape.shape.height - player.crouching_speed * delta

		if new_height > player.crouched_collision_shape_height:
			player.collision_shape.shape.height = new_height
			player.position -= Vector3(0, 0.5 * delta + 0.05, 0)
		else:
			player.collision_shape.shape.height = player.crouched_collision_shape_height
			player.position -= Vector3(0, player.crouched_collision_shape_height - player.collision_shape.shape.height + 0.05, 0)

			switch_state.emit(state_manager.states.CROUCHING, {})

func enter(previous_state_name: StringName, data: Dictionary) -> void:
	player.base_acceleration = player.defualt_base_acceleration / 2

func exit(next_state_name: StringName) -> void:
	pass
