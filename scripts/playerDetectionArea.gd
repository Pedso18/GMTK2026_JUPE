extends Area2D

var isCloseToHourglassTable = false;
var amountOfSand = 0;

func _on_body_entered(body: Node2D) -> void:
	print("body entered:", body.name)
	if(body.name == "HourglassTableRb"):
		isCloseToHourglassTable = true
	pass
	
func _on_body_exited(body: Node2D) -> void:
	if(body.name == "HourglassTableRb"):
		isCloseToHourglassTable = false
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if isCloseToHourglassTable and Input.is_action_just_pressed("ui_accept"):
		deliver_sand()
			
func deliver_sand() -> void:
# Busca todas as areias do jogo que pertencem ao grupo "areia"
	var todas_areias = get_tree().get_nodes_in_group("areia")
	var areias_para_entregar: Array = []
	# Filtra apenas as areias que estão atualmente seguindo o jogador
	for areia in todas_areias:
		if is_instance_valid(areia) and "seguindo" in areia and areia.seguindo:
			areias_para_entregar.append(areia)

	# Se houver pelo menos uma areia seguindo o jogador:
	if areias_para_entregar.size() > 0:
		var tempo_total_adicionado = areias_para_entregar.size() * 12 # o 12 é quanto cada areia vale, sujeito a mudanças
		
		# Atualiza o tempo na interface
		if has_node("%TimeLeftLabel"):
			var tempo_atual = float(%TimeLeftLabel.text)
			%TimeLeftLabel.text = str(tempo_atual + tempo_total_adicionado).substr(0, 5)

		# Zera ou atualiza a contagem visual na UI se necessário
		if has_node("%SandLabel"):
			%SandLabel.text = "0"

		# Destrói / Coleta apenas as areias que foram entregues
		for areia in areias_para_entregar:
			areia.queue_free()

	
	pass
