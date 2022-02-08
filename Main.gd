extends Control

signal letter_result(letter, state)
signal win(word)
signal loss(word)

onready var guess_container := $CenterContainer/HBoxContainer/VBoxContainer/Guesses
onready var game_state: GameState = preload("res://game_state.tres")
onready var word_set_resource = preload("res://word_set_generated.tres")

var current_row: int = 0
var solution: String
var word_set: Dictionary = {}

func _ready():
	randomize()
	
	_load_words()
	solution = _get_random_word()
	
	game_state.play()

func _load_words():
	word_set = word_set_resource.word_set

func _get_random_word():
	var keys := word_set.keys()
	return keys[randi() % keys.size()]

func _on_user_guessed(guess: String):
	if !game_state.is_play():
		return
	if !word_set.has(guess):
		return
	
	var letters = guess_container.get_children()[current_row].get_children()
	var correct_letters = 0
	for i in range(0, letters.size()):
		var letter = guess.substr(i, 1)
		letters[i].letter = letter.to_upper()
		
		if letter == solution.substr(i, 1):
			letters[i].state = 1
			correct_letters += 1
			emit_signal("letter_result", letter, 1)
		elif solution.count(letter) > 0:
			letters[i].state = 2
			emit_signal("letter_result", letter, 2)
		else:
			letters[i].state = 3
			emit_signal("letter_result", letter, 3)
	
	if correct_letters == solution.length():
		game_state.win()
		emit_signal("win", solution)
		return
	
	current_row += 1
	
	if current_row >= guess_container.get_child_count():
		game_state.lose()
		emit_signal("loss", solution)

func reset():
	get_tree().reload_current_scene()
