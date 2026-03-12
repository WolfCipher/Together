extends Area2D

@onready var root: Node2D = $".."
@onready var sprite: AnimatedSprite2D = $Enemy
@onready var animation := sprite.animation

@export var speed = 200
@export var health = 3
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

# damage

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player Attack"):
		health = health - 1
		damage_blink()
	if health < 1:
		# wait 0.5 seconds before despawning
		await get_tree().create_timer(0.5).timeout
		queue_free()
	
func damage_blink():
	var tween = create_tween()
	# switch sprite between red and normal
	if health >= 1:
		tween.tween_property(sprite, "modulate", Color(1,0,0), 0.1)
		tween.tween_property(sprite, "modulate", Color(1,1,1), 0.1)
	else:
		tween.tween_property(sprite, "modulate", Color(0.286, 0.0, 0.0, 1.0), 0.1)
