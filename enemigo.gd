extends CharacterBody2D


const SPEED = 100.0

var velorcidad_actual = SPEED


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not $RayCast2IzquierdoD.is_colliding():
		velorcidad_actual = SPEED
		$AnimatedSprite2D.flip_h = false
	if not $RayCastDerecho2D.is_colliding():
		velorcidad_actual = -SPEED
		$AnimatedSprite2D.flip_h = true
		
	velocity.x = velorcidad_actual
		
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "ChillBoy":
		body.morir()
	
