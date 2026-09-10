extends CharacterBody3D

const SPEED = 5.0
const SPRINT_SPEED = 10.0
const SENSITIVITY = 0.003
const JUMP_VELOCITY = 4.5

var camera_3d: Camera3D
var is_sprinting = false
var is_in_base = false
var current_base = null

func _ready():
	# Create camera
	camera_3d = Camera3D.new()
	camera_3d.position = Vector3(0, 1.6, 0)
	add_child(camera_3d)
	
	# Lock mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	print("Player spawned and ready")

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	
	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Movement
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Sprint
	is_sprinting = Input.is_action_pressed("ui_select")
	var speed = SPRINT_SPEED if is_sprinting else SPEED
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		camera_3d.rotate_x(-event.relative.y * SENSITIVITY)
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, -PI/2, PI/2)
	
	# Unlock mouse
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func collect_resource(resource_type: String):
	print("Collected: " + resource_type)

func enter_base(base_name: String):
	is_in_base = true
	current_base = base_name
	print("Entered: " + base_name)

func exit_base():
	is_in_base = false
	current_base = null
