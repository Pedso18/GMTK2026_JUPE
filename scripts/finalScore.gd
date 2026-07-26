extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Your final score was: %.3f"%GameManager.score
	pass # Replace with function body.


func _on_play_again_button_pressed() -> void:
	GameManager.initPlayAgain = true
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")
	pass # Replace with function body.
