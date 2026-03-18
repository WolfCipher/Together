extends Area2D

@export var speed := 1000.0
@onready var sprite: AnimatedSprite2D = $Sprite
var direction := Vector2.ZERO
var last_frame = -1 # updates until hits last frame; then dequeue meleee

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	if (sprite.frame < last_frame):
		queue_free()
	last_frame = sprite.frame

func play() -> void:
	sprite.play()
