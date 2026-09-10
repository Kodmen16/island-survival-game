extends Node3D

class_name AdvancedModelGenerator

# Advanced procedural 3D model generation with more details

func generate_airplane() -> Node3D:
	var airplane = Node3D.new()
	airplane.name = "Escape_Airplane"
	
	# Fuselage (gövde) - daha detaylı
	var fuselage = CSGCylinder3D.new()
	fuselage.radius = 3.5
	fuselage.height = 25
	fuselage.position = Vector3(0, 4, 0)
	fuselage.material = create_metallic_material(Color.LIGHT_GRAY)
	airplane.add_child(fuselage)
	
	# Cockpit (kokpit) - pilot bölümü
	var cockpit = CSGSphere3D.new()
	cockpit.radius = 2
	cockpit.position = Vector3(0, 5.5, 10)
	cockpit.material = create_metallic_material(Color.DARK_GRAY)
	airplane.add_child(cockpit)
	
	# Cockpit windows
	var window = CSGBox3D.new()
	window.size = Vector3(2, 1.5, 0.3)
	window.position = Vector3(0, 5.5, 11.5)
	window.material = create_glass_material()
	airplane.add_child(window)
	
	# Main wings (ana kanatlar)
	var left_wing = CSGBox3D.new()
	left_wing.size = Vector3(18, 0.8, 5)
	left_wing.position = Vector3(-10, 3.5, -2)
	left_wing.material = create_metallic_material(Color.LIGHT_GRAY)
	airplane.add_child(left_wing)
	
	var right_wing = CSGBox3D.new()
	right_wing.size = Vector3(18, 0.8, 5)
	right_wing.position = Vector3(10, 3.5, -2)
	right_wing.material = create_metallic_material(Color.LIGHT_GRAY)
	airplane.add_child(right_wing)
	
	# Tail (kuyruk) - vertical
	var tail_vertical = CSGBox3D.new()
	tail_vertical.size = Vector3(0.8, 8, 4)
	tail_vertical.position = Vector3(0, 8, -13)
	tail_vertical.material = create_metallic_material(Color.LIGHT_GRAY)
	airplane.add_child(tail_vertical)
	
	# Landing gear (iniş takımı)
	for x in [-3, 3]:
		var wheel = CSGCylinder3D.new()
		wheel.radius = 0.8
		wheel.height = 0.4
		wheel.position = Vector3(x, 0.4, 2)
		wheel.rotation.z = PI/2
		wheel.material = create_rubber_material()
		airplane.add_child(wheel)
	
	return airplane

func generate_military_base() -> Node3D:
	var base = Node3D.new()
	base.name = "Military_Base"
	
	# Main barracks building
	var barracks = CSGBox3D.new()
	barracks.size = Vector3(60, 25, 40)
	barracks.position = Vector3(0, 12.5, 0)
	barracks.material = create_concrete_material()
	base.add_child(barracks)
	
	# Barracks windows
	for col in range(6):
		var window = CSGBox3D.new()
		window.size = Vector3(2.5, 2, 0.2)
		window.position = Vector3(-20 + col * 8, 15, 20.2)
		window.material = create_glass_material()
		base.add_child(window)
	
	# Watch tower
	var tower_base = CSGCylinder3D.new()
	tower_base.radius = 10
	tower_base.height = 60
	tower_base.position = Vector3(30, 30, 30)
	tower_base.material = create_concrete_material()
	base.add_child(tower_base)
	
	# Radar antenna
	var antenna = CSGCylinder3D.new()
	antenna.radius = 0.8
	antenna.height = 45
	antenna.position = Vector3(30, 86, 30)
	antenna.material = create_metallic_material(Color.RED)
	base.add_child(antenna)
	
	# Guard towers at corners
	for angle in [0, PI/2, PI, 3*PI/2]:
		var guard_tower = CSGCylinder3D.new()
		guard_tower.radius = 6
		guard_tower.height = 20
		guard_tower.position = Vector3(45 * cos(angle), 10, 45 * sin(angle))
		guard_tower.material = create_concrete_material()
		base.add_child(guard_tower)
	
	# Ammunition depot
	var ammo_depot = CSGBox3D.new()
	ammo_depot.size = Vector3(20, 15, 20)
	ammo_depot.position = Vector3(-25, 7.5, -25)
	ammo_depot.material = create_concrete_material()
	base.add_child(ammo_depot)
	
	return base

func generate_house() -> Node3D:
	var house = Node3D.new()
	house.name = "Player_House"
	
	# Main walls
	var walls = CSGBox3D.new()
	walls.size = Vector3(12, 10, 12)
	walls.position = Vector3(0, 5, 0)
	walls.material = create_wood_material()
	house.add_child(walls)
	
	# Roof
	var roof = CSGBox3D.new()
	roof.size = Vector3(13, 1.5, 13)
	roof.position = Vector3(0, 11, 0)
	roof.material = create_metallic_material(Color.RED)
	house.add_child(roof)
	
	# Front door
	var door = CSGBox3D.new()
	door.size = Vector3(2.5, 5, 0.5)
	door.position = Vector3(0, 2.5, 6.25)
	door.material = create_wood_material(Color.DARK_RED)
	house.add_child(door)
	
	# Windows
	for col in range(2):
		var x = -3.5 if col == 0 else 3.5
		var window = CSGBox3D.new()
		window.size = Vector3(2, 1.8, 0.3)
		window.position = Vector3(x, 6, 0)
		window.material = create_glass_material()
		house.add_child(window)
	
	return house

func generate_character() -> Node3D:
	var character = Node3D.new()
	character.name = "Player_Character"
	
	# Head
	var head = CSGSphere3D.new()
	head.radius = 0.5
	head.position = Vector3(0, 1.9, 0)
	head.material = create_skin_material()
	character.add_child(head)
	
	# Body
	var body = CSGBox3D.new()
	body.size = Vector3(0.7, 1.2, 0.4)
	body.position = Vector3(0, 1, 0)
	body.material = create_fabric_material(Color.DARK_BLUE)
	character.add_child(body)
	
	# Arms
	for x in [-0.6, 0.6]:
		var arm = CSGCylinder3D.new()
		arm.radius = 0.2
		arm.height = 1.3
		arm.position = Vector3(x, 0.9, 0)
		arm.rotation.z = PI/2.5
		arm.material = create_fabric_material(Color.DARK_BLUE)
		character.add_child(arm)
	
	# Legs
	for x in [-0.25, 0.25]:
		var leg = CSGCylinder3D.new()
		leg.radius = 0.2
		leg.height = 1.1
		leg.position = Vector3(x, 0.4, 0)
		leg.material = create_fabric_material(Color.BLACK)
		character.add_child(leg)
	
	return character

func generate_resource(resource_type: String) -> Node3D:
	var resource = Node3D.new()
	resource.name = resource_type
	
	match resource_type:
		"stone":
			var stone = CSGSphere3D.new()
			stone.radius = 1.2
			stone.material = create_concrete_material()
			resource.add_child(stone)
		
		"wood":
			var log = CSGCylinder3D.new()
			log.radius = 1
			log.height = 2.5
			log.material = create_wood_material()
			resource.add_child(log)
		
		"metal":
			var metal = CSGBox3D.new()
			metal.size = Vector3(1.5, 0.5, 0.5)
			metal.material = create_metallic_material(Color.DARK_GRAY)
			resource.add_child(metal)
		
		"fiber":
			var fiber = CSGCylinder3D.new()
			fiber.radius = 0.8
			fiber.height = 1.5
			fiber.material = create_fabric_material(Color.YELLOW_GREEN)
			resource.add_child(fiber)
	
	return resource

# Material helper functions
func create_metallic_material(color: Color) -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = color
	mat.metallic = 0.8
	mat.roughness = 0.2
	return mat

func create_wood_material(color: Color = Color.BROWN) -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = color
	mat.roughness = 0.7
	return mat

func create_concrete_material() -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.GRAY
	mat.roughness = 0.9
	return mat

func create_glass_material() -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.7, 0.9, 1.0, 0.5)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.roughness = 0.1
	return mat

func create_rubber_material() -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.BLACK
	mat.roughness = 0.9
	return mat

func create_fabric_material(color: Color) -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = color
	mat.roughness = 0.8
	return mat

func create_skin_material() -> StandardMaterial3D:
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color.BISQUE
	mat.roughness = 0.6
	return mat
