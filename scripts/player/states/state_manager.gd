class_name PlayerStateManager extends StateManager

const states: Dictionary[String, StringName] = {
	GROUNDED = &"Grounded", 

	BEGIN_CROUCHING = &"BeginCrouching",
	CROUCHING = &"Crouching", 
	STOP_CROUCHING = &"StopCrouching",

	BEGIN_SLIDING = &"BeginSliding",
	SLIDING = &"Sliding", 
	STOP_SLIDING = &"StopSliding",

	AIRBORNE = &"Airborne",

	BEGIN_AIRBORNE_CROUCHING = &"BeginAirborneCrouching",
	AIRBORNE_CROUCHING = &"AirborneCrouching", 
	STOP_AIRBORNE_CROUCHING = &"StopAirborneCrouching",

	GLIDING = &"Gliding"}

@onready var player: Player = $".."
