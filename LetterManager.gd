extends GridContainer

const characters = [
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z"
]

onready var letter_scene := preload("res://LetterPanel.tscn")
var letter_objects = {}

func _ready():
	for character in characters:
		var letter_instance = letter_scene.instance()
		letter_instance.letter = character
		
		letter_objects[character] = letter_instance
		
		add_child(letter_instance)

func update_letter(letter: String, state: int):
	if letter_objects[letter] == null:
		return
	
	if letter_objects[letter].state == 1:
		pass
	elif letter_objects[letter].state == 2 and state == 1:
		letter_objects[letter].state = state
	else:
		letter_objects[letter].state = state
