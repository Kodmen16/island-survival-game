extends Control

class_name DigitalClock

@onready var clock_container = VBoxContainer.new()
var timezone_clocks = {}
var timezones = [
	{"name": "New York (EST)", "offset": -5},
	{"name": "London (GMT)", "offset": 0},
	{"name": "Istanbul (EET)", "offset": 2},
	{"name": "Tokyo (JST)", "offset": 9},
	{"name": "Sydney (AEDT)", "offset": 11},
	{"name": "Los Angeles (PST)", "offset": -8},
]

func _ready():
	# Setup UI
	anchor_left = 0.5
	anchor_top = 0.5
	offset_left = -200
	offset_top = -150
	custom_minimum_size = Vector2(400, 400)
	
	# Add title
	var title = Label.new()
	title.text = "World Clock"
	title.add_theme_font_size_override("font_size", 32)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	add_child(title)
	
	# Create clock container
	clock_container.separation = 15
	add_child(clock_container)
	
	# Create clocks for each timezone
	for tz in timezones:
		var clock_label = Label.new()
		clock_label.text = tz["name"] + ": --:--:--"
		clock_label.add_theme_font_size_override("font_size", 18)
		clock_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		clock_container.add_child(clock_label)
		timezone_clocks[tz["name"]] = {"label": clock_label, "offset": tz["offset"]}

func _process(_delta):
	update_clocks()

func update_clocks():
	var current_time = Time.get_ticks_msec() / 1000.0
	var dict = Time.get_datetime_dict_from_system()
	
	for tz_name in timezone_clocks.keys():
		var tz_info = timezone_clocks[tz_name]
		var offset = tz_info["offset"]
		
		# Get UTC time
		var utc_hour = dict["hour"]
		var utc_minute = dict["minute"]
		var utc_second = dict["second"]
		
		# Apply timezone offset
		var local_hour = (utc_hour + offset) % 24
		if local_hour < 0:
			local_hour += 24
		
		# Format time
		var time_string = "%02d:%02d:%02d" % [local_hour, utc_minute, utc_second]
		tz_info["label"].text = tz_name + ": " + time_string
