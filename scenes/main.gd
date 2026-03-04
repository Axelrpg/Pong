extends Node2D

@onready var game_container = $GameContainer
@onready var death_zone_left = $GameContainer/DeathZoneLeft
@onready var death_zone_right = $GameContainer/DeathZoneRight
@onready var left_score_label = $UI/HBoxContainer/LeftScoreLabel
@onready var right_score_label = $UI/HBoxContainer/RightScoreLabel

@export var left_score : int = 0:
	set(value):
		left_score = value
		if is_node_ready():
			_update_left_score()
			
@export var right_score : int = 0:
	set(value):
		right_score = value
		if is_node_ready():
			_update_right_score()
			
func _ready() -> void:
	death_zone_left.add_score.connect(_add_score)
	death_zone_right.add_score.connect(_add_score)

func _add_score(side: int) -> void:
	if multiplayer.is_server():
		match side:
			0:
				left_score += 1
			1:
				right_score += 1
		
func _update_left_score():
	left_score_label.text = str(left_score)
	
func _update_right_score():
	right_score_label.text = str(right_score)
