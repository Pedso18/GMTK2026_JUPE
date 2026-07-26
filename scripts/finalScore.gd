extends Label

func formatar_tempo(segundos_totais: float) -> Array:
	var minutos: int = int(segundos_totais) / 60
	var segundos: int = int(segundos_totais) % 60
	return [minutos, segundos]

	return [minutos, segundos]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tempo = formatar_tempo((GameManager.score/100))
	var minutos: int = tempo[0]
	var segundos: int = tempo[1]
	
	text = "Your final time was: %d minute(s) and %d second(s)" % [minutos, segundos]
	
	pass 


func _on_play_again_button_pressed() -> void:
	GameManager.initPlayAgain = true
	SceneSwitcher.switch_to_scene("res://scenes/node_2d.tscn")
	pass # Replace with function body.
