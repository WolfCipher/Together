extends Area2D

@onready var root: Node2D = $".."
@onready var sprite: AnimatedSprite2D = $Enemy
@onready var animation := sprite.animation

@export var speed = 200
@export var max_health := 3
var health := max_health
@export var faceDir = 0 # 0=up, 1=down, 2=right, 3=left
@export var target1: Node2D
@export var target2: Node2D
@export var attackDistance := 300 # distance that the enemy needs to attack
@export var attackFrequency := 1 # how frequent the attacks are
@export var projectile_scene: PackedScene
@export var AoE_scene: PackedScene

var attack_cooldown := 0.0

func _ready() -> void:
	play()
	add_to_group("Enemy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attack_cooldown -= delta
	
	# Determine target: follow whoever is closer
	var pos1 = target1.global_position
	var pos2 = target2.global_position
	var dist1 = global_position.distance_to(pos1)
	var dist2 = global_position.distance_to(pos2)
	var target_dist = min(dist1, dist2)
	var target_pos : Vector2
	
	if dist1 < dist2:
		target_pos = pos1
	else:
		target_pos = pos2
	
	# TODO some enemies attack while moving!!!!!
	# Move enemy to target, if the enemy is not within a certain distance
	# Otherwise, attack
	if target_dist > attackDistance:
		global_position = global_position.move_toward(target_pos, speed*delta)
	else:
		if attack_cooldown <= 0:
			attack()
			attack_cooldown = attackFrequency
	
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
		tween.tween_property(sprite, "modulate", Color(0.5,0,0), 0.1)
		tween.tween_property(sprite, "modulate", Color(1,1,1), 0.1)
	else:
		tween.tween_property(sprite, "modulate", Color(0.286, 0.0, 0.0, 1.0), 0.1)

func attack():
	if self.is_in_group("ProjectileEnemy"):
		shoot_projectile()
	elif self.is_in_group("AoE_Enemy"):
		create_AoE()
	else:
		print("Not projectile enemy")

# Spawn projectiles
func shoot_projectile() -> void:
	var projectile = projectile_scene.instantiate()
	var dir = get_facing_vector()
	
	# position slightly ahead of player and move in proper direction
	projectile.global_position = global_position + dir * 30
	projectile.direction = dir
	projectile.rotation = dir.angle() + PI/2
	
	# spawn
	get_tree().current_scene.add_child(projectile)

# spawn AoE attack
func create_AoE() -> void:
	var AoE = AoE_scene.instantiate()
	# position underneath enemy
	AoE.global_position = global_position
	
	# spawn
	get_tree().current_scene.add_child(AoE)

# Gives the direction the player is facing
# Ensures attacks go in the correct direction
func get_facing_vector() -> Vector2:
	match faceDir:
		0: return Vector2(0,-1)
		1: return Vector2(0,1)
		2: return Vector2(1,0)
		3: return Vector2(-1,0)
	return Vector2.ZERO
