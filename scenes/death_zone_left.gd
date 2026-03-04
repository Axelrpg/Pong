extends Area2D

signal add_score

func _on_body_exited(body: Node2D) -> void:
	if multiplayer.is_server():
		if body.is_in_group("ball"):
			add_score.emit(1)
			body.queue_free()
		
