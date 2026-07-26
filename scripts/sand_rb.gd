extends Area2D

# Quantidade de pontos que este item concede
@export var valor : int = 1

# Velocidade de movimentação ao seguir o jogador
@export var velocidade_perseguicao : float = 400.0

# Distância mínima (em pixels) para considerar que o item foi "capturado"
@export var distancia_coleta : float = 15.0

var seguindo : bool = false
var alvo_jogador : Node2D = null
var spawnerOriginario : Node2D = null

func _ready() -> void:
	# Conecta o sinal de entrada de corpo
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Quando o jogador entra na área, começa a seguir
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	if body.is_in_group("player") and not seguindo:
		seguindo = true
		var areiaIndex = int(name.substr(name.length()-1, 1))-1
		if(not GameManager.sandFollowers.has(areiaIndex)):
			GameManager.sandFollowers.append(areiaIndex)
		alvo_jogador = body
		GameManager.saveScene()
		get_tree().change_scene_to_file("res://scenes/catchingSand.tscn")


func _process(delta: float) -> void:
	# Se estiver no modo perseguidor e o jogador existir no jogo
	if seguindo and is_instance_valid(alvo_jogador):
		# Move o item na direção da posição global do jogador
		global_position = global_position.move_toward(
			Vector2(alvo_jogador.global_position.x + 20, alvo_jogador.global_position.y + 10), 
			velocidade_perseguicao * delta
		)
	

func coletar() -> void:
	# Desativa a colisão para evitar execuções duplas
	$CollisionShape2D.set_deferred("disabled", true)
	
	# Remove o item da cena
	queue_free()
