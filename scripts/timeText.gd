extends Label

@export var vignette_overlay: ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(GameManager.timeLeft).substr(0, 5)
	var targetOpacity = max((20 - float(text))/20, 0)
	var targetIntensity = max((20 - float(text))/20, 0)
	if vignette_overlay and vignette_overlay.material:
		vignette_overlay.material.set_shader_parameter("vignette_opacity", targetOpacity)
		vignette_overlay.material.set_shader_parameter("vignette_intensity", targetIntensity)
	
	
	pass
