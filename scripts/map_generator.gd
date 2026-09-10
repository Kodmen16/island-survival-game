extends Node3D

class_name MapGenerator

func generate_island() -> Node3D:
	var island = Node3D.new()
	island.name = "Island"
	
	# Create terrain
	var terrain = create_terrain()
	island.add_child(terrain)
	
	# Add military bases
	var bases = create_military_bases()
	for base in bases:
		island.add_child(base)
	
	# Add resources
	add_resource_nodes(island)
	
	return island

func create_terrain() -> Node3D:
	var terrain = Node3D.new()
	terrain.name = "Terrain"
	
	var ground = CSGBox3D.new()
	ground.size = Vector3(500, 10, 500)
	ground.position.y = -5
	ground.material = StandardMaterial3D.new()
	ground.material.albedo_color = Color.GREEN
	
	terrain.add_child(ground)
	return terrain

func create_military_bases() -> Array:
	var bases = []
	
	# Base 1 - North
	bases.append(create_base("North_Base", Vector3(-150, 0, -150)))
	
	# Base 2 - South
	bases.append(create_base("South_Base", Vector3(150, 0, 150)))
	
	# Base 3 - East
	bases.append(create_base("East_Base", Vector3(200, 0, 0)))
	
	# Base 4 - West
	bases.append(create_base("West_Base", Vector3(-200, 0, 0)))
	
	return bases

func create_base(name: String, position: Vector3) -> Node3D:
	var base = Node3D.new()
	base.name = name
	base.position = position
	
	# Base structure
	var building = CSGBox3D.new()
	building.size = Vector3(60, 30, 60)
	building.material = StandardMaterial3D.new()
	building.material.albedo_color = Color.GRAY
	
	base.add_child(building)
	
	# Tower
	var tower = CSGCylinder3D.new()
	tower.radius = 10
	tower.height = 50
	tower.position = Vector3(30, 25, 30)
	tower.material = StandardMaterial3D.new()
	tower.material.albedo_color = Color.DARK_GRAY
	
	base.add_child(tower)
	
	return base

func add_resource_nodes(island: Node3D):
	var resources = ["stone", "wood", "metal", "fiber"]
	
	for i in range(20):
		var resource_type = resources[randi() % resources.size()]
		var pos = Vector3(
			randf_range(-200, 200),
			2,
			randf_range(-200, 200)
		)
		
		var resource_node = create_resource_node(resource_type, pos)
		island.add_child(resource_node)

func create_resource_node(resource_type: String, position: Vector3) -> Node3D:
	var node = Node3D.new()
	node.name = resource_type
	node.position = position
	
	var mesh = CSGSphere3D.new()
	mesh.radius = 2
	mesh.material = StandardMaterial3D.new()
	
	match resource_type:
		"stone":
			mesh.material.albedo_color = Color.GRAY
		"wood":
			mesh.material.albedo_color = Color.BROWN
		"metal":
			mesh.material.albedo_color = Color.DARK_GRAY
		"fiber":
			mesh.material.albedo_color = Color.YELLOW
	
	node.add_child(mesh)
	return node
