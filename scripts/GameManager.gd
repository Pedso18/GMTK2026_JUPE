extends Node

var firstLoad = true
var playerPos = Vector2()
var sand1Pos = Vector2()
var sand2Pos = Vector2()
var sand3Pos = Vector2()
var sand4Pos = Vector2()
var sandFollowers = [] # carrega o index das areias que estao seguindo o player


func saveScene():
	playerPos = get_tree().get_first_node_in_group("player").global_position
	var areias = get_tree().get_nodes_in_group("areia")
	sand1Pos = areias[0].global_position
	sand2Pos = areias[1].global_position
	sand3Pos = areias[2].global_position
	sand4Pos = areias[3].global_position
	firstLoad = false
	
	pass

func loadScene():
	if(firstLoad):
		return
	var areias = get_tree().get_nodes_in_group("areia")
	areias[0].global_position = sand1Pos
	areias[1].global_position = sand2Pos
	areias[2].global_position = sand3Pos
	areias[3].global_position = sand4Pos
	
	for sandFollowerIndex in sandFollowers:
		areias[sandFollowerIndex].seguindo = true
		
	var player = get_tree().get_first_node_in_group("player")
	player.global_position = playerPos
	for sandFollowerIndex in sandFollowers:
		areias[sandFollowerIndex].alvo_jogador = player
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
