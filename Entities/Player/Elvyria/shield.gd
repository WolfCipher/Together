extends Area2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var direction := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func play() -> void:
	sprite.play()
	audio.play()
