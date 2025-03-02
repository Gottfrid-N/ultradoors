extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Player.velocity is Vector3:
		var velocity = $Player.velocity
		var facing = $Player.facing

		$VelocityLabel.text = "Velocity: %s\n / %v\n
								facing: %v, %s %s" % [velocity.length(), velocity, facing, $Player.angleh, $Player.anglev]

		var facingh = Vector2(facing.x, facing.z)*10
		var velocityh = Vector2(velocity.x, velocity.z)*20
		var vangle = velocityh.angle_to(facingh)

		$FacingVisualizer.target_position = facingh
		$VelocityVisualizer.target_position = Vector2(cos(vangle), sin(vangle)) * velocityh.length()
	else:
		$VelocityLabel.text = "velocity: " + str($Player.velocity)
