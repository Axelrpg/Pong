extends Node2D

@export var ball_scene: PackedScene

@onready var ball_spawner = $MultiplayerSpawnerBalls
@onready var ball_position = $BallPosition
@onready var timer = $Timer

func _ready() -> void:
	ball_spawner.spawn_function = _create_ball
	
	await get_tree().process_frame
	
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(_on_player_connected)
		_check_player_count()
	
func _on_player_connected(_id: int) -> void:
	_check_player_count()
		
func _check_player_count() -> void:
	if multiplayer.get_peers().size() == 2:
		timer.start()
		
func _create_ball(data):
	var instance = ball_scene.instantiate()
	
	if data is Vector2:
		instance.position = data
	
	return instance
		
func _on_timer_timeout() -> void:
	if multiplayer.is_server():
		var initial_position = ball_position.position
		ball_spawner.spawn(initial_position)
