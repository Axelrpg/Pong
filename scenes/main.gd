extends Node2D

@onready var game_container = $GameContainer
@onready var death_zone = $"GameContainer/DeathZone"
@onready var ball_count_label = $UI/Label
@onready var timer = $GameContainer/Timer

@export var game_over_scene : PackedScene

@export var ball_count : int = 0:
	set(value):
		ball_count = value
		if is_node_ready():
			_update_label()

func _ready() -> void:
	if multiplayer.is_server():
		death_zone.ball_removed.connect(remove_ball)
		timer.start()

func add_ball() -> void:
	if multiplayer.is_server():
		ball_count += 1
	
func remove_ball() -> void:
	if multiplayer.is_server():
		ball_count -= 1
		
func _update_label():
	ball_count_label.text = str(ball_count)

func _on_death_zone_game_over() -> void:
	call_deferred("_change_to_game_over_scene")

func _change_to_game_over_scene() -> void:
	get_tree().change_scene_to_packed(game_over_scene)
