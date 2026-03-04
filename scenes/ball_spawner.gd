extends Marker2D

@export var ball_scene: PackedScene

signal ball_spawned

func start() -> void:
	if multiplayer.is_server():
		_spawn_ball()

func _on_timer_timeout() -> void:
	if multiplayer.is_server():
		_spawn_ball()

func _spawn_ball():
	ball_spawned.emit()
	var ball = ball_scene.instantiate()
	add_child(ball)
