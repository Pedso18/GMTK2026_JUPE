extends CharacterBody2D

const SPEED = 3000.0
const ATRITO = 8

func _physics_process(delta: float) -> void:
	
	var accelDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if(velocity.y < -100):
		get_child(0).play("walkUp")
	elif(velocity.y > 100):
		get_child(0).play("walkDown")
	elif(velocity.x > 100):
		get_child(0).play("walkSide")
		get_child(0).flip_h = false
	elif(velocity.x < -100):
		get_child(0).play("walkSide")
		get_child(0).flip_h = true
	else:
		get_child(0).play("idle")
	
	velocity += accelDir * SPEED * delta - velocity * ATRITO * delta
	move_and_slide()


func _on_sand_rb_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
