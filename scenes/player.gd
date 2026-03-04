extends CharacterBody2D

const SPEED = 300.0

func _enter_tree() -> void:
	var id = name.to_int()
	set_multiplayer_authority(id)
	$MultiplayerSynchronizer.set_multiplayer_authority(1)

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		var direction := Input.get_axis("up", "down")
		send_input.rpc_id(1, direction)
	
	if multiplayer.is_server():
		move_and_slide()
		
@rpc("any_peer", "call_local", "unreliable")
func send_input(direction: float):
	if multiplayer.is_server():
		velocity.y = direction * SPEED

func _on_rebound_body_entered(body: Node2D) -> void:
	if not multiplayer.is_server():
		return
	
	if body.is_in_group("ball"):
		body.invert_x_direction()
