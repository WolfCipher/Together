extends Area2D

# default attributes unless otherwise modified on instantiation
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var melee_sfx: AudioStreamPlayer = $MeleeSFX
@onready var melee_talk_sfx: AudioStreamPlayer = $MeleeTalkSFX

@export var damage := 5 # melee deals more damage than projectiles

func _ready() -> void:
	play()
	melee_talk_sfx.play()
	await get_tree().create_timer(0.1).timeout
	melee_sfx.play()
	

func _process(_delta: float) -> void:
	if (sprite.frame == sprite.sprite_frames.get_frame_count("default") - 1):
		visible = false
		if !melee_talk_sfx.playing:
			queue_free()

func play() -> void:
	sprite.play()
