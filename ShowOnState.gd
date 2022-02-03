extends Control

export(GameState.States) var show_state

onready var game_state: GameState = preload("res://game_state.tres")

func _ready():
	assert(show_state != null)
	game_state.connect("state_change", self, "update_visibility")

func update_visibility(new_state):
	if show_state == new_state:
		show()
	else:
		hide()
