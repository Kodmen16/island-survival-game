extends Node3D

# Game states
var game_state = "exploration"  # exploration, crafting, combat, escape
var is_online = true
var player_inventory = {}
var base_level = 1
var discovered_plot = false

func _ready():
	print("Island Survival Game Started")
	print("Welcome! You are a wealthy businessman stranded on a military island.")
	load_game_world()
	setup_multiplayer()

func load_game_world():
	# Initialize map with military bases
	var map = MapGenerator.new()
	var island = map.generate_island()
	add_child(island)
	print("Island generated with military bases")

func setup_multiplayer():
	# Setup online multiplayer
	var multiplayer_manager = MultiplayerManager.new()
	multiplayer_manager.connect_to_server()
	print("Multiplayer server initialized")

func craft_item(item_name: String):
	print("Crafting: " + item_name)
	match item_name:
		"stone_axe":
			if inventory_has(["stone", "wood"]):
				remove_from_inventory(["stone", "wood"])
				add_to_inventory("stone_axe", 1)
		"wooden_house":
			if inventory_has(["wood", "stone", "fiber"]):
				remove_from_inventory(["wood", "stone", "fiber"])
				build_house()
		"weapon":
			if inventory_has(["metal", "wood"]):
				remove_from_inventory(["metal", "wood"])
				add_to_inventory("weapon", 1)
				trigger_discovery()

func trigger_discovery():
	discovered_plot = true
	print("VOICE MESSAGE PLAYS...")
	print("It was all planned. They know you're here. They're coming to hunt you down.")
	game_state = "combat"

func add_to_inventory(item: String, count: int):
	if not player_inventory.has(item):
		player_inventory[item] = 0
	player_inventory[item] += count

func remove_from_inventory(items: Array):
	for item in items:
		if player_inventory.has(item) and player_inventory[item] > 0:
			player_inventory[item] -= 1

func inventory_has(items: Array) -> bool:
	for item in items:
		if not player_inventory.has(item) or player_inventory[item] <= 0:
			return false
	return true

func raid_military_base():
	print("Raiding military base...")
	game_state = "combat"
	# Collect resources and recruit engineer + FBI agent

func build_escape_plane():
	if discovered_plot:
		print("Building escape plane with engineer and FBI agent...")
		# Requires specific materials from military bases
		var escape_scene = load("res://scenes/escape.tscn")
		add_child(escape_scene.instantiate())

func _process(_delta):
	pass
