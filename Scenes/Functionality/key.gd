extends Node2D

var base_color = Color(.71,.71,.71, 1.0)
var ryl_color = Color(0.314, 0.635, 0.902, 1.0)
var elvyria_color = Color(0.443, .9, 0.498, 1.0)
var together_color = Color(0.4, 0.8, 0.8, 1.0)

@export var forElvyria = false
@export var forRyl = false
@export var letter = "S"
@export var widthScale = 40
@export var heightScale = 40

@onready var keyRect = $Panel
@onready var text = $Panel/Letter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var color = together_color if (forElvyria && forRyl) else elvyria_color if forElvyria else ryl_color if forRyl else base_color
	
	keyRect.size = Vector2(widthScale, heightScale)
	
	var styleBox: StyleBoxFlat = keyRect.get_theme_stylebox("panel").duplicate()
	styleBox.set("bg_color", color)
	keyRect.add_theme_stylebox_override("panel", styleBox)
	
	text.text = letter
