extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Your final score was: \n" + str(GameManager.score)
	pass # Replace with function body.
