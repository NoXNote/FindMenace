extends Button

signal tic_pressed(button_index: int)

@export var button_index : int = -1
var state := 0:
	set(new_state):
		if new_state == 0:
			icon = preload("res://assets/dash.png")
		elif new_state == 1:
			icon = preload("res://assets/o.png")
		elif new_state == 2:
			icon = preload("res://assets/x.png")
		else:
			push_error("Invalid state! Must be 0, 1 or 2.")
		state = new_state
	get:
		return state
func press_tic():
	if state == 0: tic_pressed.emit(button_index)
	
func _on_pressed() -> void:
	press_tic()
