extends CharacterBody2D

var speed_x = 100
var speed_y = 100

func _ready() -> void:
	if multiplayer.is_server():
		_randomize_direction()
		
func _randomize_direction():
	var direction_x = randi_range(0, 1)
	if direction_x == 1:
		speed_x *= -1
		
	var direction_y = randi_range(0, 1)
	if direction_y == 1:
		speed_y *= -1
		
func _physics_process(_delta: float) -> void:
	if multiplayer.is_server():
		velocity.x = speed_x
		velocity.y = speed_y
		move_and_slide()
	
func invert_x_direction():
	if not multiplayer.is_server():
		return
	
	speed_x *= -1
	if (speed_x > 0):
		speed_x += 5
	else:
		speed_x -= 5

func invert_y_direction():
	if not multiplayer.is_server():
		return
	
	speed_y *= -1
	if (speed_y > 0):
		speed_y += 1
	else:
		speed_y -= 1
