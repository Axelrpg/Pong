extends Area2D

signal ball_removed

func _on_body_exited(body: Node2D) -> void:
	if multiplayer.is_server():
		if body.is_in_group("ball"):
			ball_removed.emit()
			body.queue_free()
		
