extends Area2D

@export var speed := 1000.0
@export var damage := 1 # projectiles deal less damage than melee

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var direction := Vector2.ZERO

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		global_position += direction * speed * delta

func play() -> void:
	sprite.play()
	audio.play()

func _on_area_entered(area: Area2D) -> void:
	var player_attack = self.is_in_group("Player Attack") && area.is_in_group("Enemy");
	var enemy_attack = self.is_in_group("Enemy Attack") && area.is_in_group("Player");
	
	if player_attack || enemy_attack:
		queue_free()
