extends Resource
class_name GameState

signal state_change(new_state)

enum States {
	PLAYING,
	WIN,
	LOSE
}
export var game_state: int setget _set_game_state

func win():
	_set_game_state(States.WIN)

func lose():
	_set_game_state(States.LOSE)

func play():
	_set_game_state(States.PLAYING)

func is_play(): 
	return game_state == States.PLAYING


func _set_game_state(new_game_state):
	game_state = new_game_state
	emit_signal("state_change", new_game_state)
