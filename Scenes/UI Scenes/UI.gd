extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	find_children("*", "Button")[0].grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
