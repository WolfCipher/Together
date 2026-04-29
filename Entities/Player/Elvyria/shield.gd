extends Area2D

@onready var sprite: AnimatedSprite2D = $Sprite

var direction := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		global_position += direction

func play() -> void:
	sprite.play()
