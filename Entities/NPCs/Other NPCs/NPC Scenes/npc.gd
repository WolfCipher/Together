extends Node2D

@onready var sprite = $Sprite
@onready var dialog = $Trigger

@export var line = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play()
	if dialog:
		dialog.line = line


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
