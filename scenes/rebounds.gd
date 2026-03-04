extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if not multiplayer.is_server():
		return
	
	if body.is_in_group("ball"):
		body.invert_y_direction()
