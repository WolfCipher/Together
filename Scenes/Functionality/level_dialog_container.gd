extends Node

const dialog = preload("res://Scenes/Functionality/level_dialog.tscn")
@onready var choices = $Choices

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneCache.create_dialog.connect(on_create_dialog)
	SceneCache.create_dialog.emit("ryl", 0, "What's the Dullworld?")
	await get_tree().create_timer(2).timeout
	SceneCache.create_dialog.emit("elvyria", 0, "...This world.")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## character: String for animation name, used to select which character
## emotion: index for frame, used to select the emotion of the character
## text: text stated by the character
func on_create_dialog(character, emotion, text):
	var dialog_ctrl = dialog.instantiate()
	var dialog_text = dialog_ctrl.get_node("Text")
	var dialog_character = dialog_ctrl.get_node("Character")
	
	dialog_text.text = text
	dialog_character.animation = character
	dialog_character.frame = emotion
	
	# Control how it appears and disappears from the screen (fade-in and fade-out)
	# Control how long it stays on the screen
	dialog_ctrl.modulate = Color(1,1,1,0)
	var fade_speed = 0.25
	var duration = 5
	
	var fade_in = create_tween()
	choices.add_child(dialog_ctrl)
	fade_in.tween_property(dialog_ctrl,"modulate", Color(1,1,1,1), fade_speed)
	await fade_in.finished
	
	await get_tree().create_timer(duration).timeout
	
	var fade_out = create_tween()
	fade_out.tween_property(dialog_ctrl,"modulate", Color(1,1,1,0), fade_speed)
	await fade_out.finished
	
	choices.remove_child(dialog_ctrl)
