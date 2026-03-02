extends Label

var menace_db: Dictionary = {}

# The 8 symmetry rotation
const ROTATIONS = [
	[0, 1, 2, 3, 4, 5, 6, 7, 8], [2, 5, 8, 1, 4, 7, 0, 3, 6],
	[8, 7, 6, 5, 4, 3, 2, 1, 0], [6, 3, 0, 7, 4, 1, 8, 5, 2],
	[2, 1, 0, 5, 4, 3, 8, 7, 6], [8, 5, 2, 7, 4, 1, 6, 3, 0],
	[6, 7, 8, 3, 4, 5, 0, 1, 2], [0, 3, 6, 1, 4, 7, 2, 5, 8]
]

# Maps Top-Left to Bottom-Right grid into Menace's Bottom-Left to Top-Right grid
const GODOT_TO_MENACE_MAP = [6, 7, 8, 3, 4, 5, 0, 1, 2]

func _ready() -> void:
	load_json_db()

func load_json_db() -> void:
	var file = FileAccess.open("res://menace_ids.json", FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		menace_db = JSON.parse_string(json_string)
		print("MENACE DB Loaded. Total states: ", menace_db.size())
	else:
		push_error("Could not find menace_ids.json!")

func get_board_id(godot_board: Array) -> String:
	# Translate Godot grid to Menace grid
	var menace_board = [0,0,0,0,0,0,0,0,0]
	for i in range(9):
		menace_board[GODOT_TO_MENACE_MAP[i]] = godot_board[i]
	
	# Find the maximum Base-3 value among all 8 symmetries
	var max_base3_val = -1
	
	for rot in ROTATIONS:
		var current_val = 0
		for i in range(9):
			# Godot 4 supports ** for integer exponents
			current_val += (3 ** i) * menace_board[rot[i]]
		
		if current_val > max_base3_val:
			max_base3_val = current_val
			
	# Look up in the JSON dictionary
	var key_str = str(max_base3_val)
	if menace_db.has(key_str):
		text = "ID is: " + str(menace_db[key_str])
		return str(menace_db[key_str])
	else:
		text = "ID is: N/A"
		return "N/A"
