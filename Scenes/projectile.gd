extends Area2D

@export var speed := 1000.0
var direction := Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	var player_attack = self.is_in_group("Player Attack") && area.is_in_group("Enemy");
	var enemy_attack = self.is_in_group("Enemy Attack") && area.is_in_group("Player");
	
	if player_attack || enemy_attack:
		queue_free()
