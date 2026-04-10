# warning-ignore-all:return_value_discarded

extends Node

@export var ink_script := "res://Ink/test.json"
@export var ink_vars := ["ryl", "elvyria", "btn1", "btn2", "btn3", "btn4", "dialog"] # should be populated with the strings of Inky variable names
@export var next_scene : String

@onready var _ink_player = InkPlayer.new()
var choice_btn
const generic_btn = preload("res://Ink/Functionality/dialog_button.tscn")
const elvyria_btn = preload("res://Ink/Functionality/elvyria_button.tscn")
const ryl_btn = preload("res://Ink/Functionality/ryl_button.tscn")
var _btns = []

@onready var panel = $Panel # holds everything; turn invisible when dialogue is finished
@onready var dialog_box = $Panel/Dialog
@onready var choices = $Panel/Choices # append buttons to this vertical box container
@onready var speaker = $Panel/Speaker # icon chosen for dialog box
var btn_type = [0,0,0,0] # icon chosen for each button

# icons for buttons and dialog box
const ryl_icon = preload("res://Ink/Functionality/ryl_icon.png")
const elvyria_icon = preload("res://Ink/Functionality/elvyria_icon.png")

# Character emotions
@onready var ryl = $Ryl
const ryl_neutral = preload("res://Ink/Character Expressions/Ryl/Ryl_Neutral.png")
const ryl_happy = preload("res://Ink/Character Expressions/Ryl/Ryl_Happy.png")
const ryl_determined = preload("res://Ink/Character Expressions/Ryl/Ryl_Determined.png")
const ryl_concern = preload("res://Ink/Character Expressions/Ryl/Ryl_Concern.png")
const ryl_shocked = preload("res://Ink/Character Expressions/Ryl/Ryl_Shocked.png")
@onready var elvyria = $Elvyria
const elvyria_neutral = preload("res://Ink/Character Expressions/Elvyria/Elvyria_Neutral.png")
const elvyria_happy = preload("res://Ink/Character Expressions/Elvyria/Elvyria_Happy.png")
const elvyria_determined = preload("res://Ink/Character Expressions/Elvyria/Elvyria_Determined.png")
const elvyria_concern = preload("res://Ink/Character Expressions/Elvyria/Elvyria_Concern.png")
const elvyria_shocked = preload("res://Ink/Character Expressions/Elvyria/Elvyria_Shocked.png")

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

	call_deferred("_continue_story")


# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story():

	# the text placed in the label (dialog box)
	if _ink_player.can_continue:
		var text = _ink_player.continue_story()
		dialog_box.set_deferred("text", text)
	
	# button choices
	if _ink_player.has_choices:
		
		# 'current_choices' contains a list of the choices, as strings.
		var _index = 0
		for choice in _ink_player.current_choices:
			#print(choice.text)
			#print(choice.tags)
			
			if (btn_type[_index] == 0):
				choice_btn = elvyria_btn
			elif (btn_type[_index] == 1):
				choice_btn = ryl_btn
			else:
				choice_btn = generic_btn
			
			var btn = choice_btn.instantiate()
			btn.text = choice.text
			
			_btns.append(btn)
			choices.add_child(btn)
			
			# button now has an index and pressing it will be recognized
			btn.pressed.connect(self._index_choose.bind(btn))
			
			_index += 1
		
			
	# This code runs when the story reaches its end.
	else:
		panel.visible = false
		#get_tree().change_scene_to_file(next_scene)
		SceneCache.scene_change.emit(next_scene)
	


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
	
	match variable_name:
		"ryl":
			match new_value:
				0: ryl.set_deferred("texture", ryl_neutral)
				1: ryl.set_deferred("texture", ryl_happy)
				2: ryl.set_deferred("texture", ryl_determined)
				3: ryl.set_deferred("texture", ryl_concern)
				4: ryl.set_deferred("texture", ryl_shocked)
		"elvyria":
			match new_value:
				0: elvyria.set_deferred("texture", elvyria_neutral)
				1: elvyria.set_deferred("texture", elvyria_happy)
				2: elvyria.set_deferred("texture", elvyria_determined)
				3: elvyria.set_deferred("texture", elvyria_concern)
				4: elvyria.set_deferred("texture", elvyria_shocked)
		"btn1":
			btn_type[0] = new_value
		"btn2":
			btn_type[1] = new_value
		"btn3":
			btn_type[2] = new_value
		"btn4":
			btn_type[3] = new_value
		"dialog":
			match new_value:
				0: speaker.set_deferred("texture", elvyria_icon)
				1: speaker.set_deferred("texture", ryl_icon)
				_: speaker.set_deferred("texture", null)
	
	print("Variable '%s' changed to: %s" % [variable_name, new_value])
