extends GridContainer

@onready var button_template := $"../ticButton"
@onready var who_turn_sign := $"../whoTurn"
var board_array: Array[Button]

class Move:
	var position: int
	var previous_state: int
	func _init(pos, p_state):
		position = pos
		previous_state = p_state

var move_history: Array[Move]
var undo_history: Array[Move]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in 9:
		var temp_button = button_template.duplicate() as Button
		temp_button.tic_pressed.connect(_on_tic_button_tic_pressed)
		temp_button.visible = true
		temp_button.button_index = i
		board_array.append(temp_button)
		add_child(temp_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tic_button_tic_pressed(button_index: int) -> void:
	undo_history.clear()
	move_history.push_back(Move.new(button_index, board_array[button_index].state))
	changeTurn()
	if Globals.xTurn:
		board_array[button_index].state = 1
	else:
		board_array[button_index].state = 2
	print(button_index)
	


func _on_undo_pressed() -> void:
	if move_history.size() > 0:
		changeTurn()
		undo_history.push_back(Move.new(move_history[-1].position, board_array[move_history[-1].position].state)) 
		board_array[move_history[-1].position].state = move_history[-1].previous_state
		
		move_history.pop_back()
		print(undo_history[-1].position)
		print(undo_history[-1].previous_state)


func _on_redo_pressed() -> void:
	if undo_history.size() > 0:
		changeTurn()
		move_history.push_back(Move.new(undo_history[-1].position, board_array[undo_history[-1].position].state)) 
		board_array[undo_history[-1].position].state = undo_history[-1].previous_state
		
		undo_history.pop_back()


func changeTurn():
	Globals.xTurn = !Globals.xTurn
	if Globals.xTurn: who_turn_sign.texture = preload("res://assets/xturn.png")
	else: who_turn_sign.texture = preload("res://assets/oturn.png")
