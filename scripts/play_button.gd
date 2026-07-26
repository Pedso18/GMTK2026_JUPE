extends Button

func _on_credits_button_pressed() -> void:
	SceneSwitcher.switch_to_scene("res://scenes/creditsScreen.tscn")
	pass # Replace with function body.


func _on_play_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	SceneSwitcher.switch_to_scene("res://scenes/node_2d.tscn")
	pass # Replace with function body.
