class_name State extends Node

signal switch_state(next_state_path: NodePath, data: Dictionary)

func handle_input(event: InputEvent):
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter(previous_state_path: NodePath, data: Dictionary) -> void:
	pass

func exit() -> void:
	pass