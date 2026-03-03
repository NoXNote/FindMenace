extends Label

@export var hz_stripe :Node
@export var vr_stripe :Node
@export var diaga_stripe :Node
@export var diagb_stripe :Node

@export var player_sound:Node
@export var menace_sound :Node

@export var who_turn : Node

@export var cover : Node

# Store 8 winning combinations
const WIN_LINES = [
	[0, 1, 2], [3, 4, 5], [6, 7, 8], # Horizontal Rows
	[0, 3, 6], [1, 4, 7], [2, 5, 8], # Vertical Columns
	[0, 4, 8], [2, 4, 6]             # Diagonals
]

func check_winner(board: Array) -> int:
	print("Checked")
	var win_index := 0
	for line in WIN_LINES:
		# Check if the first square isn't empty, and if all three match
		var a = line[0]
		var b = line[1]
		var c = line[2]
		
		if board[a] != 0 and board[a] == board[b] and board[a] == board[c]:
			print("won!")
			if board[a] == 1: 
				text = "O has Won!"
				who_turn.texture = preload("res://assets/win.png")
				player_sound.play()
			elif board[a] == 2: 
				text = "X has Won!"
				who_turn.texture = preload("res://assets/lose.png")
				menace_sound.play()
			
			display_win(win_index)
			return board[a]
		win_index+=1 
	text = "No winner yet"
	display_win(-1)
	return 0 
	
func display_win(index):
	hz_stripe.visible = false
	vr_stripe.visible = false
	diaga_stripe.visible = false
	diagb_stripe.visible = false
	cover.visible = false
	match index:
		0:
			hz_stripe.position = Vector2(20,265)
			hz_stripe.visible = true
			cover.visible = true
		1:
			hz_stripe.position = Vector2(20,380)
			hz_stripe.visible = true
			cover.visible = true
		2:
			hz_stripe.position = Vector2(20,495)
			hz_stripe.visible = true
			cover.visible = true
		3:
			vr_stripe.position = Vector2(60.0,235.0)
			vr_stripe.visible = true
			cover.visible = true
		4:
			vr_stripe.position = Vector2(175.0,235.0)
			vr_stripe.visible = true
			cover.visible = true
		5:
			vr_stripe.position = Vector2(290.0,235.0)
			vr_stripe.visible = true
			cover.visible = true
		6:
			diaga_stripe.visible = true
			cover.visible = true
		7:
			diagb_stripe.visible = true
			cover.visible = true
