tool
extends EditorScript

var word_set_resource = preload("res://WordSet.gd")

func _run():
	var words = load_words()
	var words_resource = create_word_set_resource(words)
	
	ResourceSaver.save("res://word_set_generated.tres", words_resource, ResourceSaver.FLAG_COMPRESS)

func load_words():
	var word_file := File.new()
	word_file.open("res://words.txt", File.READ)
	
	var word_set = {}
	while not word_file.eof_reached():
		var word := word_file.get_line().strip_edges().to_lower()
		
		if word.length() != 5:
			print("Tried to read in word '%s' that is not length 5" % word)
			continue
		
		word_set[word] = true
	
	print("Finished reading in words")
	return word_set

func create_word_set_resource(words: Dictionary):
	var word_set_instance = word_set_resource.new()
	word_set_instance.word_set = words
	
	return word_set_instance
