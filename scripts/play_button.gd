extends Button

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/creditsScreen.tscn")
	pass # Replace with function body.


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")
	pass # Replace with function body.
