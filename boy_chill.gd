extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1000.0

var muerto = false


func _physics_process(delta: float) -> void:
	# Si está muerto, no puede moverse
	if muerto:
		return

	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0

	move_and_slide()


func _process(delta: float) -> void:

	# Si está muerto, no cambiar la animación
	if muerto:
		return

	# ATAQUE MIENTRAS SE MANTIENE PRESIONADO SHIFT
	if Input.is_action_pressed("golpe"):
		$AnimatedSprite2D.play("atacar")
	else:
		# Movimiento
		if velocity.x > 0:
			$AnimatedSprite2D.play("caminando")
			$AnimatedSprite2D.flip_h = false

		elif velocity.x < 0:
			$AnimatedSprite2D.play("caminando")
			$AnimatedSprite2D.flip_h = true

		else:
			$AnimatedSprite2D.play("idle")


func morir() -> void:
	if muerto:
		return

	muerto = true
	velocity = Vector2.ZERO

	$AnimatedSprite2D.play("muerte")

	print("has muerto")
	
	await $AnimatedSprite2D.animation_finished

	get_tree().quit()
