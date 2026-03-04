extends Node2D

@export var ball_scene: PackedScene

@onready var ball_spawner = $MultiplayerSpawnerBalls
@onready var ball_position = $BallPosition

func _ready() -> void:
	ball_spawner.spawn_function = _create_ball
	
	await get_tree().process_frame
	
	if multiplayer.multiplayer_peer == null:
		return
		
	if multiplayer.is_server():
		_spawn_ball()
		
func _create_ball(data):
	var instance = ball_scene.instantiate()
	
	if data is Vector2:
		instance.position = data
	
	return instance

func _spawn_ball():
	if multiplayer.is_server():
		var initial_position = ball_position.position
		ball_spawner.spawn(initial_position)
		get_parent().ball_count += 1
		
func _on_timer_timeout() -> void:
	if multiplayer.is_server():
		var initial_position = ball_position.position
		ball_spawner.spawn(initial_position)
		get_parent().ball_count += 1
