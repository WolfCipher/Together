extends AnimatedSprite2D

@onready var root: Node2D = $".."
@export var speed = 400

func _ready() -> void:
	self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get movement direction from WASD
	var dir := Input.get_vector("e_left", "e_right", "e_up", "e_down")

	# Move the sprite
	position += dir * speed * delta

	# Handle animations
	if dir == Vector2.ZERO:
		animation = "idle"
		play()
		return

	# Determine animation based on direction
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			animation = "right"
		else:
			animation = "left"
	else:
		if dir.y > 0:
			animation = "down"
		else:
			animation = "up"

	play()
