extends AnimatedSprite2D

@onready var root: Node2D = $".."

func _ready() -> void:
	self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
