extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
@export var max_speed: float = 2000.0
@export var accel: float = 50.0 # Higher = snappier, Lower = floatier/heavier

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var distance = global_position.distance_to(mouse_pos)
	
	# Desired velocity scales down as we get closer to prevent overshooting
	var target_velocity = Vector2.ZERO
	if distance > 2.0:
		# Scale speed down when within 100px of mouse for a smooth arrival
		var current_speed = minf(max_speed, distance * 5.0)
		target_velocity = global_position.direction_to(mouse_pos) * current_speed

	# Smoothly blend current velocity toward target velocity
	velocity = velocity.lerp(target_velocity, accel * delta)
	
	move_and_slide()
