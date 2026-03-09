extends Area2D

@onready var root: Node2D = $".."
@onready var sprite: AnimatedSprite2D = $Enemy
@onready var animation := sprite.animation

@export var speed = 200
@export var faceDir = 0 # 0=up, 1=down, 2=right, 3=left
@export var target1: Node2D
@export var target2: Node2D
@export var attackDistance := 100 # distance that the enemy needs to attack

func _ready() -> void:
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Determine target: follow whoever is closer
	var pos1 = target1.global_position
	var pos2 = target2.global_position
	var dist1 = abs(global_position - pos1)
	var dist2 = abs(global_position - pos2)
	var target_dist
	var target_pos : Vector2
	
	if dist1 < dist2:
		target_dist = dist1.length()
		target_pos = pos1
	else:
		target_dist = dist2.length()
		target_pos = pos2
	
	# Move enemy to target, if the enemy is within a certain distance
	if target_dist > attackDistance:
		global_position = global_position.move_toward(target_pos, speed*delta)
	
	# Determine the direction and handle animations accordingly
	var dir = (target_pos - global_position).normalized()

	# Handle animations
	var animation = sprite.animation
	
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

func play() -> void:
	sprite.animation = animation
	sprite.play()
