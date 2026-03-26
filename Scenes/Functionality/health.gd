extends ProgressBar

@export var character: Node2D

func _ready() -> void:
	max_value = character.max_health
	value = character.health

func _process(_delta: float) -> void:
	value = character.health
