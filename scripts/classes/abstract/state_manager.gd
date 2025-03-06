class_name StateManager extends Node

@onready var state: State = get_child(0)

func _ready() -> void:
	for state_node: State in get_children():
		state_node.switch_state.connect(_to_next_state)

	await owner.ready
	state.enter("null", {})

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _to_next_state(next_state_name: StringName, data: Dictionary) -> void:
	assert(has_node(NodePath(next_state_name)), "Node: %s does not exist" % next_state_name)

	var previous_state_path := state.name
	state.exit(next_state_name)
	state = get_node(NodePath(next_state_name))
	state.enter(previous_state_path, data)
