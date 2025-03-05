extends PlayerState

func handle_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.move_camera_from_mouse(event)

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		switch_state.emit(state_manager.states.GROUNDED, {})

	player.apply_gravity(delta)
	player.apply_acceleration(delta)

func enter(previous_state_path: NodePath, data: Dictionary) -> void:
	pass

func exit() -> void:
	pass