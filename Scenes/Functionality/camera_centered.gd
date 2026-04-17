extends Camera2D

@export var speed = 400
@export var target1: Node2D
@export var target2: Node2D

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

var trauma = 0.0  # Current shake strength.
var trauma_power = 1.2  # Trauma exponent. Use [2, 3].

# Start exactly at the right point
func _ready() -> void:
	var pos1 = target1.global_position
	var pos2 = target2.global_position
	var x = (pos1.x + pos2.x)/2
	var y = (pos1.y + pos2.y)/2
	var target_pos = Vector2(x,y)
	
	
	global_position = target_pos


# Move to average of targets
func _process(delta: float) -> void:
	var pos1 = target1.global_position
	var pos2 = target2.global_position
	var x = (pos1.x + pos2.x)/2
	var y = (pos1.y + pos2.y)/2
	var target_pos = Vector2(x,y)
	
	# Screen Shake
	
	if target1 && target2:
		global_position = target_pos
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	
	global_position = global_position.move_toward(target_pos, speed*delta)
	
	
func add_trauma(amount):
	trauma = min(trauma + amount, .2)
	
func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

func _on_damaged() -> void:
	print("Shake!!!")
	add_trauma(1)
	
#Screen Shake From KidsCanCode
