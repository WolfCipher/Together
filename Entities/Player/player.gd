extends AnimatedSprite2D

@onready var root: Node2D = $".."
@export var speed = 400
@export var faceDir = 0 # 0=up, 1=down, 2=right, 3=left

# character dependent variables
@export var up := "e_up"
@export var down := "e_down"
@export var right := "e_right"
@export var left := "e_left"

func _ready() -> void:
	self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get movement direction from WASD
	var dir := Input.get_vector(left, right, up, down)

	# Move the sprite
	position += dir * speed * delta

	# Handle animations
	if dir == Vector2.ZERO:
		
		match faceDir:
			0: animation = "idle_up"
			1: animation = "idle_down"
			2: animation = "idle_right"
			3: animation = "idle_left"
		play()
		return

	# Determine animation based on direction
	if abs(dir.y) > abs(dir.x):
		if dir.y > 0:
			animation = "walk_down"
			faceDir = 1
		else:
			animation = "walk_up"
			faceDir = 0
	else:
		if dir.x > 0:
			animation = "walk_right"
			faceDir = 2
		else:
			animation = "walk_left"
			faceDir = 3

	play()
