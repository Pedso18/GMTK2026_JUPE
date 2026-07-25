extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("grainOfSand").is_empty():
		print("win win win")
	pass


func _on_bucket_area_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("grainOfSand"):
		print("one less sand!")
		body.queue_free()
	pass # Replace with function body.
