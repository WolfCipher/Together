extends AnimatedSprite2D

@onready var root: Node2D = $".."
@export var speed = 400
# 0=up, 1=down, 2=right, 3=left; lets idle animations face the right direction
@export var faceDir = 0

# character dependent variables
@export var up := "e_up"
@export var down := "e_down"
@export var right := "e_right"
@export var left := "e_left"
@export var attack1 := "e_attack1"
@export var attack2 := "e_attack2"

func _ready() -> void:
	self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# ***** MOVEMENT ******
	var dir := Input.get_vector(left, right, up, down)
	position += dir * speed * delta
	
	# ***** ATTACKS *****
	# Regular attacks
	if Input.is_action_pressed(attack1):
		var _x = 1 # placeholder to prevent errors
	if Input.is_action_pressed(attack2):
		var _x = 1 # placeholder to prevent errors
	
	# Sync attacks
	if Input.is_action_pressed("e_sync") && Input.is_action_pressed("r_sync"):
		var _x = 1 # placeholder to prevent errors

	# ***** ANIMATIONS *****
	# Determine animation based on direction
	# idle
	if dir == Vector2.ZERO:
		match faceDir:
			0: animation = "idle_up"
			1: animation = "idle_down"
			2: animation = "idle_right"
			3: animation = "idle_left"
	
	# walk
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
