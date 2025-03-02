extends SpotLight3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var color = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	color += delta
	if color > 1:
		color -= 1

	light_color = Color.from_hsv(float(color), 1.0, 1.0)
