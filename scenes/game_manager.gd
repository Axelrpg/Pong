extends Node

@export var player_scene: PackedScene
@export var game_container: Node2D

const ip = "10.8.0.1"
const port = 7777

func _ready() -> void:
	randomize()
	
	if "--server" in OS.get_cmdline_args():
		start_server()
	elif "--client" in OS.get_cmdline_args():
		get_tree().create_timer(1)
		start_client()

func start_server():
	get_window().title = "SERVIDOR"
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	
	print("Servidor escuchando en puerto", port)

func start_client():
	get_window().title = "CLIENTE"
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(_on_connected)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	
func _on_connected():
	print("✅ Conectado al servidor")

func _on_connection_failed():
	print("❌ Falló la conexión")

func _on_server_disconnected():
	print("⚠️ Servidor desconectado")
	
func _on_peer_connected(id: int) -> void:
	if multiplayer.is_server():
		print("Jugador conectado con ID:", id)
		_spawn_player(id)

func _on_peer_disconnected(id: int) -> void:
	print("Jugador desconectado con ID:", id)
	
func _spawn_player(id: int) -> void:
	var new_player = player_scene.instantiate()
	new_player.name = str(id)
	new_player.set_multiplayer_authority(id)
	
	var random_color = Color.from_hsv(randf(), 0.8, 1.0)
	new_player.modulate = random_color
	
	var initial_position: Vector2
	initial_position = game_container.get_node("PlayerPosition").global_position
	new_player.global_position = initial_position
	game_container.add_child(new_player)
