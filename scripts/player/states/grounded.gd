extends PlayerState

func handle_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		player.velocity += Vector3(0, 5, 0)

	if event.is_action_pressed("crouch"):
		switch_state.emit(state_manager.states.CROUCHING, {})

	if event is InputEventMouseMotion:
		player.move_camera_from_mouse(event)

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		switch_state.emit(state_manager.states.AIRBORNE, {})

	player.apply_friction(delta)
	player.apply_acceleration(delta)

func enter(previous_state_name: StringName, data: Dictionary) -> void:
	pass

func exit(next_state_name: StringName) -> void:
	pass
