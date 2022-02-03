extends LineEdit

signal user_guessed(guess)

func _on_text_entered(new_text: String):
	if new_text != null and new_text.length() == 5:
		emit_signal("user_guessed", new_text)
		text = ''
