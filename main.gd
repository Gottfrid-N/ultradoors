extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Player.velocity is Vector3:
			$DebugLabel.text = "pos: %v\nvelocity: %v accel_dir: %v in: %v\nfacing: %v h: %v\neurot: %v h: %v" % [
			$Player.position, $Player.velocity, $Player.accel_direction, $Player.input_direction, 
			$Player.facing, $Player.facingh, $Player/Pivot.rotation, $Player/HorizontalPivot.rotation]

			var angle = $Player.velocityh2d.angle_to($Player.facingh2d)
			$RelativeVelocityVisualizer.target_position = Vector2(0, -1).rotated(angle)*$Player.speed
