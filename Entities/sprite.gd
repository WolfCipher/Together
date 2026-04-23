extends Node2D

@onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
