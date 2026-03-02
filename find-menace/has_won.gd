extends Label

# Store 8 winning combinations
const WIN_LINES = [
	[0, 1, 2], [3, 4, 5], [6, 7, 8], # Horizontal Rows
	[0, 3, 6], [1, 4, 7], [2, 5, 8], # Vertical Columns
	[0, 4, 8], [2, 4, 6]             # Diagonals
]

func check_winner(board: Array) -> int:
	print("Checked")
	for line in WIN_LINES:
		# Check if the first square isn't empty, and if all three match
		var a = line[0]
		var b = line[1]
		var c = line[2]
		
		if board[a] != 0 and board[a] == board[b] and board[a] == board[c]:
			print("won!")
			if board[a] == 1: text = "O has Won!"
			elif board[a] == 2: text = "X has Won!"
			return board[a]
	text = "No winner yet"
	return 0 
