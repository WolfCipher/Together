extends Camera2D

@export var speed = 400
@export var target1: Node2D
@export var target2: Node2D

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
	
	global_position = global_position.move_toward(target_pos, speed*delta)
