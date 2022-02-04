tool
extends Panel

export(Color) var correct_position_color setget _set_correct_position_color
export(Color) var correct_letter_color setget _set_correct_letter_color

export(String) var letter setget _set_letter
export(int, "empty", "correct_position", "correct_letter", "incorrect_letter") var state setget _set_state

func _ready():
	update_look()

func _set_correct_position_color(color):
	correct_position_color = color
	update_look()

func _set_correct_letter_color(color):
	correct_letter_color = color
	update_look()

func _set_letter(new_letter: String):
	assert(new_letter.length() <= 1)
	$Label.text = new_letter
	letter = new_letter

func _set_state(new_state: int):
	if new_state != state:
		state = new_state
		update_look()

func update_look():
	if state == 0:
		reset_color()
	elif state == 1:
		set_color(correct_position_color)
	elif state == 2:
		set_color(correct_letter_color)
	elif state == 3:
		reset_color()
	update()

func set_color(color: Color):
	var default_stylebox: StyleBoxFlat = get_stylebox("panel").duplicate()
	default_stylebox.bg_color = color
	
	add_stylebox_override("panel", default_stylebox)

func reset_color():
	add_stylebox_override("panel", null)
