extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Player.velocity is Vector3:
		$DebugLabel.text = "pos: %v\nvelocity: %v speed: %s\naccel_dir: %v in: %v\nfacing: %v h: %v\neurot: %v h: %v\nstate: %s" % [
		$Player.position, $Player.velocity, $Player.speed, $Player.acceleration_direction, $Player.input_direction, 
		$Player.facing, $Player.facingh, $Player/Camera.rotation, $Player/HorizontalPivot.rotation, $Player/StateManager.state.name]

		var vel2d = Vector2(-$Player.velocityh2d.x, $Player.velocityh2d.y)
		var angle = vel2d.angle_to(Vector2(-$Player.facingh2d.x, $Player.facingh2d.y))
		$RelativeVelocityVisualizer.target_position = Vector2(0, -1).rotated(angle)*$Player.speed
