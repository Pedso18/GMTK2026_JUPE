extends Button

func _on_credits_button_pressed() -> void:
	print("credits")
	pass # Replace with function body.


func _on_play_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")
	pass # Replace with function body.
