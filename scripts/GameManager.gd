extends Node

var firstLoad = true
var playerPos = Vector2()
var sand1Pos = Vector2()
var sand2Pos = Vector2()
var sand3Pos = Vector2()
var sand4Pos = Vector2()
var sand1SpawnerName = null
var sand2SpawnerName = null
var sand3SpawnerName = null
var sand4SpawnerName = null

var timeLeft = 60
var score = 0
var alive = true

var initPlayAgain = false

const INITIAL_TIME = 60

var sandFollowers = [] # carrega o index das areias que estao seguindo o player

var rng = RandomNumberGenerator.new()

func saveScene():
	playerPos = get_tree().get_first_node_in_group("player").global_position
	var areias = get_tree().get_nodes_in_group("areia")
	
	sand1Pos = areias[0].global_position
	sand2Pos = areias[1].global_position
	sand3Pos = areias[2].global_position
	sand4Pos = areias[3].global_position
	
	sand1SpawnerName = areias[0].spawnerOriginario.name
	sand2SpawnerName = areias[1].spawnerOriginario.name
	sand3SpawnerName = areias[2].spawnerOriginario.name
	sand4SpawnerName = areias[3].spawnerOriginario.name
	
	firstLoad = false
	
	pass

func loadScene():
	if(firstLoad):
		timeLeft = INITIAL_TIME
		score = 0
		var areias = get_tree().get_nodes_in_group("areia")
		var sandSpawners = get_tree().get_nodes_in_group("sandSpawners")
		
		for areia in areias:
			var spawnerIndex = rng.randi_range(0, sandSpawners.size()-1)
			while(sandSpawners[spawnerIndex].hasSand):
				# garante que não teremos duas areias em um mesmo spawner
				spawnerIndex = rng.randi_range(0, sandSpawners.size()-1)
			areia.global_position = sandSpawners[spawnerIndex].global_position
			sandSpawners[spawnerIndex].hasSand = true
			areia.spawnerOriginario = sandSpawners[spawnerIndex]
		return
		
	var areias = get_tree().get_nodes_in_group("areia")
	areias[0].global_position = sand1Pos
	areias[1].global_position = sand2Pos
	areias[2].global_position = sand3Pos
	areias[3].global_position = sand4Pos
	
	var sand1Spawner = get_tree().root.find_child(sand1SpawnerName, true, false)
	var sand2Spawner = get_tree().root.find_child(sand2SpawnerName, true, false)
	var sand3Spawner = get_tree().root.find_child(sand3SpawnerName, true, false)
	var sand4Spawner = get_tree().root.find_child(sand4SpawnerName, true, false)
	
	areias[0].spawnerOriginario = sand1Spawner
	areias[1].spawnerOriginario = sand2Spawner
	areias[2].spawnerOriginario = sand3Spawner
	areias[3].spawnerOriginario = sand4Spawner
	
	sand1Spawner.hasSand = true
	sand2Spawner.hasSand = true
	sand3Spawner.hasSand = true
	sand4Spawner.hasSand = true
	
	for sandFollowerIndex in sandFollowers:
		areias[sandFollowerIndex].seguindo = true
		
	var player = get_tree().get_first_node_in_group("player")
	player.global_position = playerPos
	for sandFollowerIndex in sandFollowers:
		areias[sandFollowerIndex].alvo_jogador = player
	

func playAgain():
	initPlayAgain = false
	timeLeft = INITIAL_TIME
	score = 0
	alive = true
	var player = get_tree().get_first_node_in_group("player")
	
	playerPos = Vector2(430, 327)
	
	
	
	var areias = get_tree().get_nodes_in_group("areia")
	var sandSpawners = get_tree().get_nodes_in_group("sandSpawners")
	
	for areia in areias:
		var spawnerIndex = rng.randi_range(0, sandSpawners.size()-1)
		while(sandSpawners[spawnerIndex].hasSand):
			# garante que não teremos duas areias em um mesmo spawner
			spawnerIndex = rng.randi_range(0, sandSpawners.size()-1)
		areia.global_position = sandSpawners[spawnerIndex].global_position
		sandSpawners[spawnerIndex].hasSand = true
		areia.spawnerOriginario = sandSpawners[spawnerIndex]
	
	player.global_position = playerPos
	print("alive:", alive)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	timeLeft -= delta + delta * 0.2 * score / 6000
	if(timeLeft <= 0 and alive):
		
		alive = false
		get_tree().change_scene_to_file("res://scenes/finalScreen.tscn")
	elif (timeLeft > 0):
		score += delta * 100
	pass
