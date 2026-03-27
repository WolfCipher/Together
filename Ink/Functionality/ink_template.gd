# warning-ignore-all:return_value_discarded

extends Node

@export var ink_script := "res://Ink/test.json"
@export var ink_vars := [] # should be populated with the strings of Inky variable names
@export var next_scene : String

# TODO Add character sprites emotions to switch between here

@onready var _ink_player = InkPlayer.new()
@onready var choice_btn
@onready var generic_btn = load("res://Ink/Functionality/dialog_button.tscn")
@onready var elvyria_btn = load("res://Ink/Functionality/elvyria_button.tscn")
@onready var ryl_btn = load("res://Ink/Functionality/ryl_button.tscn")
@onready var _btns = []

@onready var panel = $Panel # holds everything; turn invisible when dialogue is finished
@onready var dialog_box = $Panel/Dialog
@onready var choices = $Panel/Choices # append buttons to this vertical box container

var use_elvyria = true
var use_ryl = false

func _ready():
	# Adds the player to the tree.
	add_child(_ink_player)

	# Loads story
	_ink_player.ink_file = load(ink_script)

	# It's recommended to load the story in the background. On platforms that
	# don't support threads, the value of this variable is ignored.
	_ink_player.loads_in_background = true

	_ink_player.connect("loaded", Callable(self, "_story_loaded"))

	# Creates the story. 'loaded' will be emitted once Ink is ready
	# continue the story.
	_ink_player.create_story()


# ############################################################################ #
# Signal Receivers
# ############################################################################ #

func _story_loaded(successfully: bool):
	if !successfully:
		return

	_observe_variables()
	# _bind_externals()

	_continue_story()


# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story():
	# the text placed in the label (dialog box)
	while _ink_player.can_continue:
		var text = _ink_player.continue_story()
		
		dialog_box.text = text
	
	# button choices
	if _ink_player.has_choices:
		# 'current_choices' contains a list of the choices, as strings.
		for choice in _ink_player.current_choices:
			#print(choice.text)
			#print(choice.tags)
			
			if (use_elvyria):
				choice_btn = elvyria_btn
			elif (use_ryl):
				choice_btn = ryl_btn
			else:
				choice_btn = generic_btn
			
			var btn = choice_btn.instantiate()
			btn.text = choice.text
			
			_btns.append(btn)
			choices.add_child(btn)
			
			# button now has an index and pressing it will be recognized
			btn.pressed.connect(self._index_choose.bind(btn))
			
	# This code runs when the story reaches its end.
	else:
		panel.visible = false
		get_tree().change_scene_to_file(next_scene)

# Handles getting index from button so choice can be selected
func _index_choose(button):
	var index = _btns.find(button)
	if index != -1:
		_select_choice(index)

func _select_choice(index):
	# prepare for next set of choices by removing this set of choices
	for button in choices.get_children():
		button.queue_free()
	
	_btns.clear()
	
	_ink_player.choose_choice_index(index)
	_continue_story()


# Uncomment to bind an external function.
#
# func _bind_externals():
#     _ink_player.bind_external_function("<function_name>", self, "_external_function")
#
#
# func _external_function(arg1, arg2):
#     pass


# Uncomment to observe the variables from your ink story.
# You can observe multiple variables by adding them in the array.
func _observe_variables():
	_ink_player.observe_variables(ink_vars, self, "_variable_changed")
#
#
func _variable_changed(variable_name, new_value):
	# use if variable_name == "X" to determine what to change
	# use new_value to determine what to change to
	print("Variable '%s' changed to: %s" % [variable_name, new_value])
