extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Player.velocity is Vector3:
		$VelocityLabel.text = "velocity: " + str($Player.velocity.length()) + "\n
								x velocity: " + str($Player.velocity.x) + "\n
								y velocity: " + str($Player.velocity.y) + "\n
								z velocity: " + str($Player.velocity.z) + "\n"
		var facing = Vector2($Player.facing.x, $Player.facing.z)*10
		var velocity = Vector2($Player.velocity.x, $Player.velocity.z)*20
		var vangle = velocity.angle_to(facing)

		$FacingVisualizer.target_position = facing
		$VelocityVisualizer.target_position = Vector2(cos(vangle), sin(vangle)) * velocity.length()
	else:
		$VelocityLabel.text = "velocity: " + str($Player.velocity)
