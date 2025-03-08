extends PlayerState

func handle_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.move_camera_from_mouse(event)

	if event.is_action_released("crouch"):
		switch_state.emit(state_manager.states.STOP_AIRBORNE_CROUCHING, {})

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		switch_state.emit(state_manager.states.CROUCHING, {})

	player.apply_gravity(delta)
	player.apply_acceleration(delta)

func enter(previous_state_name: StringName, data: Dictionary) -> void:
	pass

func exit(next_state_name: StringName) -> void:
	pass
