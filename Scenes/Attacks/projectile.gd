extends Area2D

# default attributes unless otherwise modified on instantiation
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
	
	if player_attack || enemy_attack || area.is_in_group("Shield"):
		queue_free()
	
	var ryl_enhance = self.is_in_group("RylProjectile") && area.is_in_group("ElvyriaMelee");
	var elvyria_enhance = self.is_in_group("ElvyriaProjectile") && area.is_in_group("RylMelee");
	
	if (ryl_enhance || elvyria_enhance):
		damage += 2;
		
		var tween = create_tween()
		if (ryl_enhance):
			tween.tween_property(sprite, "modulate", Color(2,2,0.5), 0.1)
		else:
			tween.tween_property(sprite, "modulate", Color(1,1.5,100), 0.1)
		
