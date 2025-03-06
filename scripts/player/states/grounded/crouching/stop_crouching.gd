extends PlayerState

func handle_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.move_camera_from_mouse(event)
	
	if event.is_action_pressed("crouch"):
		switch_state.emit(state_manager.states.BEGIN_CROUCHING, {})

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		switch_state.emit(state_manager.states.STOP_AIRBORNE_CROUCHING, {})

	if player.collision_shape.shape.height < player.collision_shape_height:
		player.collision_shape.shape.height += player.collision_shape_height * delta
		player.position += Vector3(0, 0.5 * delta, 0)
	else:
		player.position += Vector3(0, player.collision_shape_height - player.collision_shape.shape.height, 0)
		player.collision_shape.shape.height = player.crouched_collision_shape_height
		
		switch_state.emit(state_manager.states.GROUNDED, {})

func enter(previous_state_name: StringName, data: Dictionary) -> void:
	pass

func exit(next_state_name: StringName) -> void:
	player.base_acceleration = player.defualt_base_acceleration