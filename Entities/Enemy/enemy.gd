extends Area2D

@onready var root: Node2D = $".."
@onready var sprite: AnimatedSprite2D = $Enemy
@onready var animation := sprite.animation
@onready var death_particles := CPUParticles2D.new()
@onready var tex := load("res://death_particle.png") 

@export var speed = 200
@export var max_health := 3
var health := max_health

@export var damage = 1 # contact damage; must be named this, since it is accessed by this name by the player
@export var AoE_damage = 1
@export var projectile_damage = 1
@export var melee_damage = 5

@export var faceDir = 0 # 0=up, 1=down, 2=right, 3=left

@export var target1: Node2D
@export var target2: Node2D

@export var mustBeStillToAttack = true # false for AoE enemy that leaves behind harmful magic
@export var attackDistance := 300 # distance that the enemy needs to attack
@export var attackFrequency := 1 # how frequent the attacks are
var attack_cooldown := 0.0

@export var projectile_scene: PackedScene
@export var AoE_scene: PackedScene
@export var melee_scene: PackedScene

func _ready() -> void:
	play()
	add_to_group("Enemy")
	add_child(death_particles)
	death_particles.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# enemy can only do something if it's not dead
	if health > 0:
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
		
		var too_far = target_dist > attackDistance
		var align_dist = 40 # how far off from exactly matched a axis position can be and still hit
		var vert_aligned = abs(global_position.y - target_pos.y) <= align_dist
		var horiz_aligned = abs(global_position.x - target_pos.x) <= align_dist
		var continue_moving = too_far || (!vert_aligned && !horiz_aligned)
		
		if continue_moving:
			global_position = global_position.move_toward(target_pos, speed*delta)
		
		# HANDLE ANIMATIONS
		# Determine the direction and handle animations accordingly
		var dir = (target_pos - global_position).normalized()
		animate(dir)
		
		# note: attack after handling animation to ensure faceDir is updated
		if (!continue_moving) || (!mustBeStillToAttack):
			if attack_cooldown <= 0:
				attack()
				attack_cooldown = attackFrequency

func play() -> void:
	sprite.animation = animation
	sprite.play()

func animate(dir) -> void:
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

# damage
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player Attack"):
		health = health - area.damage
		damage_blink()
	if health < 1:
		spawn_death_particles()
		# wait 0.5 seconds before despawning
		await get_tree().create_timer(0.5).timeout
		queue_free()
		
	# contact enemies disappear immediately on contact with the player
	# will only blink red when on contact with an attack
	elif self.is_in_group("DisappearOnContact") && area.is_in_group("Player"):
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
	telegraph()
	await get_tree().create_timer(0.35).timeout
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
	projectile.speed = 700
	projectile.global_position = global_position + dir * 30
	projectile.direction = dir
	projectile.rotation = dir.angle() + PI/2
	
	# use enemy's specified damage
	projectile.damage = projectile_damage
	
	# spawn
	get_tree().current_scene.add_child(projectile)

# spawn AoE attack
func create_AoE() -> void:
	var AoE = AoE_scene.instantiate()
	
	# position underneath enemy
	AoE.global_position = global_position
	
	# use enemy's specified damage
	AoE.damage = AoE_damage
	
	# spawn
	get_tree().current_scene.add_child(AoE)

# spawn melee attack
func attack_melee() -> void:
	var melee = melee_scene.instantiate()
	var dir = get_facing_vector()
	
	# position slightly ahead of player and move in proper direction
	melee.global_position = global_position + dir * 30
	melee.direction = dir
	melee.rotation = dir.angle() + PI/2
	
	# use enemy's specified damage
	melee.damage = melee_damage
	
	# spawn
	get_tree().current_scene.add_child(melee)

# Gives the direction the player is facing
# Ensures attacks go in the correct direction
func get_facing_vector() -> Vector2:
	match faceDir:
		0: return Vector2(0,-1)
		1: return Vector2(0,1)
		2: return Vector2(1,0)
		3: return Vector2(-1,0)
	return Vector2.ZERO
	
#Squash and stretch shoot telegraph
func telegraph():
	
	find_child("Enemy").scale.y = 1.1
	find_child("Enemy").scale.x = 1.1
	await get_tree().create_timer(0.2).timeout
	find_child("Enemy").scale.x = 1
	find_child("Enemy").scale.y = 1

#handles spawning and creation of death particles
func spawn_death_particles():
	# Load the image resource
	death_particles.texture = tex
	#define death particles
	death_particles.one_shot = true
	death_particles.initial_velocity_min = 400
	death_particles.initial_velocity_max = 500
	death_particles.scale_amount_min = 8
	death_particles.scale_amount_max = 8
	death_particles.gravity = Vector2(0,0)
	death_particles.lifetime = .4
	death_particles.spread = 180
	death_particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_RING
	death_particles.amount = 20
	death_particles.explosiveness = 1
	death_particles.z_index = 100 
	death_particles.z_as_relative = false
	death_particles.global_position = global_position
	death_particles.emitting = true
