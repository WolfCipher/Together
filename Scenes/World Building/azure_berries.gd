extends Area2D
@onready var sprite = $Sprite

@export var health_boost = 4
var used = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") && area.health < area.max_health &&!used:
		used = true
		area.health = min(area.max_health, area.health+health_boost)
		queue_free()
