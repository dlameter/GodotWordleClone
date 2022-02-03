extends Control

onready var guess_container := $CenterContainer/VBoxContainer/Guesses
onready var game_state: GameState = preload("res://game_state.tres")

var current_row: int = 0
var solution: String
var word_set: Dictionary = {}

func _ready():
	randomize()
	
	_load_words()
	solution = _get_random_word()
	
	game_state.play()

func _load_words():
	var word_file := File.new()
	word_file.open("res://words.txt", File.READ)
	
	while not word_file.eof_reached():
		var word := word_file.get_line().strip_edges().to_lower()
		
		if word.length() != 5:
			print("Tried to read in word '%s' that is not length 5" % word)
			continue
		
		word_set[word] = true
	
	print("Finished reading in words")

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
		letters[i].letter = letter
		
		if letter == solution.substr(i, 1):
			letters[i].state = 1
			correct_letters += 1
		elif solution.count(letter) > 0:
			letters[i].state = 2
		else:
			letters[i].state = 3
	
	if correct_letters == solution.length():
		game_state.win()
		return
	
	current_row += 1
	
	if current_row >= guess_container.get_child_count():
		game_state.lose()

func restart():
	get_tree().reload_current_scene()
