extends Control

onready var guess_container := $CenterContainer/VBoxContainer/Guesses
onready var win_screen := $CenterContainer/WinScreen
onready var lose_screen := $CenterContainer/LoseScreen
var current_row: int = 0
var solution: String
var word_set: Dictionary = {}

enum GameState {
	PLAYING,
	WIN,
	LOSE
}
var game_state: int setget _set_game_state

func _ready():
	randomize()
	
	_load_words()
	solution = _get_random_word()
	
	_set_game_state(GameState.PLAYING)

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
	if game_state != GameState.PLAYING:
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
		_set_game_state(GameState.WIN)
		return
	
	current_row += 1
	
	if current_row >= guess_container.get_child_count():
		_set_game_state(GameState.LOSE)

func _set_game_state(new_game_state):
	game_state = new_game_state
	
	print(game_state)
	if game_state == GameState.PLAYING:
		win_screen.hide()
		lose_screen.hide()
	elif game_state == GameState.WIN:
		win_screen.show()
		lose_screen.hide()
	elif game_state == GameState.LOSE:
		win_screen.hide()
		lose_screen.show()

func restart():
	get_tree().reload_current_scene()
