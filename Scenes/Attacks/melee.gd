extends Area2D

@onready var sprite: AnimatedSprite2D = $Sprite
@export var damage := 5 # melee deals more damage than projectiles

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	if (sprite.frame == sprite.sprite_frames.get_frame_count("default") - 1):
		queue_free()

func play() -> void:
	sprite.play()
