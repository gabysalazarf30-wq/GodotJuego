extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("fuego")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "ChillBoy":
		body.morir()
