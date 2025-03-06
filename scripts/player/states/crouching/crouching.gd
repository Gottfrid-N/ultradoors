extends PlayerState

func handle_input(event: InputEvent):
	if event is InputEventMouseMotion:
		player.move_camera_from_mouse(event)

	if event.is_action_released("crouch"):
		switch_state.emit(state_manager.states.GROUNDED, {})

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		switch_state.emit(state_manager.states.AIRBORNE_CROUCHING, {})

	player.apply_friction(delta)
	player.apply_acceleration(delta)

func enter(previous_state_name: StringName, data: Dictionary) -> void:
	if previous_state_name != state_manager.states.AIRBORNE_CROUCHING:
		print(previous_state_name)
		print(state_manager.states.AIRBORNE_CROUCHING)
		player.to_crouched_collision()
		player.position -= Vector3(0, 1, 0)
	player.acceleration = 25

func exit(next_state_name: StringName) -> void:
	if next_state_name != state_manager.states.AIRBORNE_CROUCHING:
		player.acceleration = player.defualt_acceleration
		player.position += Vector3(0, 1, 0)
		player.to_normal_collision()
