extends Label

var original_text: String

func _ready():
	original_text = text

func set_word(word: String):
	text = original_text % word
