class_name PlayerStateManager extends StateManager

const states := {
	GROUNDED = &"Grounded", 
	CROUCHING = &"Crouching", 
	SLIDING = &"Sliding", 
	AIRBORNE = &"Airborne", 
	AIRBORNE_CROUCHING = &"AirborneCrouching", 
	GLIDING = &"Gliding"}

@onready var player: Player = $".."
