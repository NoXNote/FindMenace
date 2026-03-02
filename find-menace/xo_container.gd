extends GridContainer

@onready var button_template := $"../ticButton"
@onready var who_turn_sign := $"../whoTurn"
@onready var id_output = $"../whatID"
@onready var previous_reset = $"../say_previous"

@onready var has_won = $"../hasWon"

@onready var menace_core = $"../whatID"

var board_array: Array[Button]

class Move:
	var position: int
	var previous_state: int
	func _init(pos, p_state):
		position = pos
		previous_state = p_state

var move_history: Array[Move]
var undo_history: Array[Move]

func _ready() -> void:
	
	for i in 9:
		var temp_button = button_template.duplicate() as Button
		temp_button.tic_pressed.connect(_on_tic_button_tic_pressed)
		temp_button.visible = true
		temp_button.button_index = i
		temp_button.state = 0
		board_array.append(temp_button)
		add_child(temp_button)


func get_board() -> Array[int]:
	var int_array: Array[int]
	for but in board_array:
		int_array.push_back(but.state)
	return int_array
	
func _on_tic_button_tic_pressed(button_index: int) -> void:
	undo_history.clear()
	move_history.push_back(Move.new(button_index, board_array[button_index].state))
	if Globals.xTurn:
		board_array[button_index].state = 2
	else:
		board_array[button_index].state = 1
	changeTurn()
	
func _on_undo_pressed() -> void:
	if move_history.size() > 0:
		undo_history.push_back(Move.new(move_history[-1].position, board_array[move_history[-1].position].state)) 
		board_array[move_history[-1].position].state = move_history[-1].previous_state
		
		move_history.pop_back()
		print(undo_history[-1].position)
		print(undo_history[-1].previous_state)
		changeTurn()

func _on_redo_pressed() -> void:
	if undo_history.size() > 0:
		move_history.push_back(Move.new(undo_history[-1].position, board_array[undo_history[-1].position].state)) 
		board_array[undo_history[-1].position].state = undo_history[-1].previous_state
		
		undo_history.pop_back()
		changeTurn()

func changeTurn():
	Globals.xTurn = !Globals.xTurn
	if Globals.xTurn: who_turn_sign.texture = preload("res://assets/xturn.png")
	else: who_turn_sign.texture = preload("res://assets/oturn.png")
	has_won.check_winner(get_board())
	menace_core.get_board_id(get_board())

func _on_reset_pressed() -> void:
	Globals.xTurn = true
	who_turn_sign.texture = preload("res://assets/xturn.png")
	var reset_text = ""
	for i in 9:
		reset_text += str(board_array[i].state)
		if i % 3 == 2: reset_text += "\n"
		board_array[i].state = 0
	previous_reset.text = reset_text
	undo_history.clear()
	move_history.clear()
	has_won.check_winner(get_board())
	menace_core.get_board_id(get_board())
