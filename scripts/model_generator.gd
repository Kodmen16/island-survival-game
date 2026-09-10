extends Node3D

class_name ModelGenerator

# Generate all 3D models procedurally
func generate_airplane() -> Node3D:
	var airplane = Node3D.new()
	airplane.name = "Escape_Airplane"
	
	# Fuselage (gövde)
	var fuselage = CSGCylinder3D.new()
	fuselage.radius = 3
	fuselage.height = 20
	fuselage.position = Vector3(0, 3, 0)
	fuselage.material = StandardMaterial3D.new()
	fuselage.material.albedo_color = Color.LIGHT_GRAY
	airplane.add_child(fuselage)
	
	# Cockpit (kokpit)
	var cockpit = CSGSphere3D.new()
	cockpit.radius = 1.5
	cockpit.position = Vector3(0, 4.5, 8)
	cockpit.material = StandardMaterial3D.new()
	cockpit.material.albedo_color = Color.DARK_GRAY
	airplane.add_child(cockpit)
	
	# Wings (kanatlar)
	var left_wing = CSGBox3D.new()
	left_wing.size = Vector3(15, 0.5, 4)
	left_wing.position = Vector3(-8, 3, 0)
	left_wing.material = StandardMaterial3D.new()
	left_wing.material.albedo_color = Color.LIGHT_GRAY
	airplane.add_child(left_wing)
	
	var right_wing = CSGBox3D.new()
	right_wing.size = Vector3(15, 0.5, 4)
	right_wing.position = Vector3(8, 3, 0)
	right_wing.material = StandardMaterial3D.new()
	right_wing.material.albedo_color = Color.LIGHT_GRAY
	airplane.add_child(right_wing)
	
	# Tail (kuyruk)
	var tail = CSGBox3D.new()
	tail.size = Vector3(0.5, 5, 3)
	tail.position = Vector3(0, 5, -10)
	tail.material = StandardMaterial3D.new()
	tail.material.albedo_color = Color.LIGHT_GRAY
	airplane.add_child(tail)
	
	# Engines (motorlar)
	for x in [-4, 4]:
		var engine = CSGCylinder3D.new()
		engine.radius = 1.2
		engine.height = 3
		engine.position = Vector3(x, 2, 2)
		engine.material = StandardMaterial3D.new()
		engine.material.albedo_color = Color.DARK_GRAY
		airplane.add_child(engine)
	
	return airplane

func generate_house() -> Node3D:
	var house = Node3D.new()
	house.name = "Player_House"
	
	# Main structure
	var walls = CSGBox3D.new()
	walls.size = Vector3(12, 8, 12)
	walls.position = Vector3(0, 4, 0)
	walls.material = StandardMaterial3D.new()
	walls.material.albedo_color = Color.BROWN
	house.add_child(walls)
	
	# Roof (çatı)
	var roof = CSGBox3D.new()
	roof.size = Vector3(13, 1, 13)
	roof.position = Vector3(0, 9, 0)
	roof.material = StandardMaterial3D.new()
	roof.material.albedo_color = Color.RED
	house.add_child(roof)
	
	# Door
	var door = CSGBox3D.new()
	door.size = Vector3(2, 4, 0.5)
	door.position = Vector3(0, 2, 6.25)
	door.material = StandardMaterial3D.new()
	door.material.albedo_color = Color.DARK_RED
	house.add_child(door)
	
	# Windows
	for z in [-3, 3]:
		for x in [-3, 3]:
			var window = CSGBox3D.new()
			window.size = Vector3(1.5, 1.5, 0.3)
			window.position = Vector3(x, 5, z)
			window.material = StandardMaterial3D.new()
			window.material.albedo_color = Color.LIGHT_BLUE
			house.add_child(window)
	
	return house

func generate_military_base() -> Node3D:
	var base = Node3D.new()
	base.name = "Military_Base"
	
	# Main building
	var building = CSGBox3D.new()
	building.size = Vector3(60, 30, 60)
	building.position = Vector3(0, 15, 0)
	building.material = StandardMaterial3D.new()
	building.material.albedo_color = Color.GRAY
	base.add_child(building)
	
	# Watch tower (gözetleme kulesi)
	var tower = CSGCylinder3D.new()
	tower.radius = 8
	tower.height = 50
	tower.position = Vector3(30, 25, 30)
	tower.material = StandardMaterial3D.new()
	tower.material.albedo_color = Color.DARK_GRAY
	base.add_child(tower)
	
	# Radar antenna
	var antenna = CSGCylinder3D.new()
	antenna.radius = 2
	antenna.height = 40
	antenna.position = Vector3(30, 65, 30)
	antenna.material = StandardMaterial3D.new()
	antenna.material.albedo_color = Color.RED
	base.add_child(antenna)
	
	# Walls
	for i in range(4):
		var wall = CSGBox3D.new()
		wall.size = Vector3(60, 8, 2)
		wall.position = Vector3(0, 4, 30 if i % 2 == 0 else -30)
		wall.rotation.y = TAU / 4 * i
		wall.material = StandardMaterial3D.new()
		wall.material.albedo_color = Color.DARK_GRAY
		base.add_child(wall)
	
	# Guard posts (nöbet kulübeleri)
	for angle in [0, PI/2, PI, 3*PI/2]:
		var post = CSGBox3D.new()
		post.size = Vector3(4, 4, 4)
		post.position = Vector3(40 * cos(angle), 2, 40 * sin(angle))
		post.material = StandardMaterial3D.new()
		post.material.albedo_color = Color.DARK_RED
		base.add_child(post)
	
	return base

func generate_weapon(weapon_type: String) -> Node3D:
	var weapon = Node3D.new()
	weapon.name = weapon_type
	
	match weapon_type:
		"rifle":
			# Barrel
			var barrel = CSGCylinder3D.new()
			barrel.radius = 0.3
			barrel.height = 8
			barrel.rotation.z = PI/2
			barrel.material = StandardMaterial3D.new()
			barrel.material.albedo_color = Color.DARK_GRAY
			weapon.add_child(barrel)
			
			# Stock
			var stock = CSGBox3D.new()
			stock.size = Vector3(0.5, 0.5, 3)
			stock.position = Vector3(-2, 0, 0)
			stock.material = StandardMaterial3D.new()
			stock.material.albedo_color = Color.BROWN
			weapon.add_child(stock)
		
		"pistol":
			# Slide
			var slide = CSGBox3D.new()
			slide.size = Vector3(0.5, 2, 4)
			slide.material = StandardMaterial3D.new()
			slide.material.albedo_color = Color.DARK_GRAY
			weapon.add_child(slide)
			
			# Grip
			var grip = CSGBox3D.new()
			grip.size = Vector3(0.4, 3, 1)
			grip.position = Vector3(0, 0, 0.5)
			grip.material = StandardMaterial3D.new()
			grip.material.albedo_color = Color.BROWN
			weapon.add_child(grip)
	
	return weapon

func generate_character() -> Node3D:
	var character = Node3D.new()
	character.name = "Player_Character"
	
	# Head
	var head = CSGSphere3D.new()
	head.radius = 0.4
	head.position = Vector3(0, 1.8, 0)
	head.material = StandardMaterial3D.new()
	head.material.albedo_color = Color.BISQUE
	character.add_child(head)
	
	# Body
	var body = CSGBox3D.new()
	body.size = Vector3(0.6, 1, 0.4)
	body.position = Vector3(0, 1, 0)
	body.material = StandardMaterial3D.new()
	body.material.albedo_color = Color.DARK_BLUE
	character.add_child(body)
	
	# Arms
	for x in [-0.5, 0.5]:
		var arm = CSGCylinder3D.new()
		arm.radius = 0.15
		arm.height = 1.2
		arm.position = Vector3(x, 0.8, 0)
		arm.rotation.z = PI/2
		arm.material = StandardMaterial3D.new()
		arm.material.albedo_color = Color.BISQUE
		character.add_child(arm)
	
	# Legs
	for x in [-0.2, 0.2]:
		var leg = CSGCylinder3D.new()
		leg.radius = 0.15
		leg.height = 1
		leg.position = Vector3(x, 0.3, 0)
		leg.material = StandardMaterial3D.new()
		leg.material.albedo_color = Color.BLACK
		character.add_child(leg)
	
	return character

func generate_resource(resource_type: String) -> Node3D:
	var resource = Node3D.new()
	resource.name = resource_type
	
	var mesh = CSGSphere3D.new()
	mesh.radius = 1
	mesh.material = StandardMaterial3D.new()
	
	match resource_type:
		"stone":
			mesh.radius = 1.2
			mesh.material.albedo_color = Color.GRAY
		"wood":
			var cylinder = CSGCylinder3D.new()
			cylinder.radius = 0.8
			cylinder.height = 2
			cylinder.material = StandardMaterial3D.new()
			cylinder.material.albedo_color = Color.BROWN
			resource.add_child(cylinder)
			return resource
		"metal":
			mesh.radius = 0.9
			mesh.material.albedo_color = Color.DARK_GRAY
		"fiber":
			mesh.radius = 0.7
			mesh.material.albedo_color = Color.YELLOW_GREEN
	
	resource.add_child(mesh)
	return resource
