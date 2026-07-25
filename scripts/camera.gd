extends Camera2D
@export var target_node: Node2D

var rng = RandomNumberGenerator.new()
var shakeStrength = 0

func _process(delta: float) -> void:
	if target_node:
		position = position.lerp(target_node.position, 10.0 * delta)
	var timeLeft = float(%TimeLeftLabel.text)
	if(fmod(timeLeft, 10) < 0.1 and timeLeft <= 31):
		shakeStrength = 30
	if(shakeStrength > 0):
		shakeStrength = lerpf(shakeStrength, 0, 5 * delta)
		offset = Vector2(rng.randf_range(-shakeStrength, shakeStrength), rng.randf_range(-shakeStrength, shakeStrength))
