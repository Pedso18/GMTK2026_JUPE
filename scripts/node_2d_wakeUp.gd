extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(GameManager.initPlayAgain):
		GameManager.playAgain()
	else:
		GameManager.loadScene()
	pass # Replace with function body.
