extends Area2D

@onready var dialog = $NpcDialog
var dialog_text : Label

@export var line = "" # what the NPC says
var numPlayers = 0 # tracks number of players in range

func _ready() -> void:
	
	# set text
	dialog_text = dialog.get_node("Text")
	dialog_text.text = line
	
	# dialog transparent unless players within range
	var tween = create_tween()
	tween.tween_property(dialog, "modulate", Color(1,1,1,0), 0)

func _process(_delta: float) -> void:
	if !dialog_text.text && line:
		dialog_text.text = line

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		numPlayers += 1
	if (numPlayers == 1):
		var tween = create_tween()
		tween.tween_property(dialog, "modulate", Color(1,1,1,1), 0.2)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		numPlayers -= 1
	if (numPlayers == 0):
		var tween = create_tween()
		tween.tween_property(dialog, "modulate", Color(1,1,1,0), 0.2)
