extends Node

class_name MultiplayerManager

var peer = ENetMultiplayerPeer.new()
var players = {}
var game_server_port = 9999

func connect_to_server():
	print("Connecting to multiplayer server...")
	
	# For single player testing, create local server
	if peer.create_server(game_server_port) != OK:
		print("ERROR: Could not create server")
		return
	
	multiplayer.multiplayer_peer = peer
	print("Multiplayer server created on port " + str(game_server_port))
	
	# Connect signals
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func join_server(server_ip: String = "localhost"):
	if peer.create_client(server_ip, game_server_port) != OK:
		print("ERROR: Could not create client")
		return
	
	multiplayer.multiplayer_peer = peer
	print("Connecting to server at " + server_ip)

func _on_peer_connected(peer_id: int):
	print("Player connected: " + str(peer_id))
	players[peer_id] = {"name": "Player_" + str(peer_id), "inventory": {}}

func _on_peer_disconnected(peer_id: int):
	print("Player disconnected: " + str(peer_id))
	if peer_id in players:
		players.erase(peer_id)

@rpc("any_peer", "call_local")
func sync_player_action(player_id: int, action: String, data: Dictionary):
	print("Player " + str(player_id) + " performed: " + action)

@rpc("any_peer", "call_local")
func broadcast_message(message: String):
	print("[BROADCAST] " + message)
