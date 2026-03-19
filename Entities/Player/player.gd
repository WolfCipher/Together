extends Area2D

signal game_over

@onready var root: Node2D = $".."
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation := sprite.animation
@onready var walk: AudioStreamPlayer = $AudioStreamPlayer


@export var speed = 400
# 0=up, 1=down, 2=right, 3=left; lets idle animations face the right direction
@export var faceDir = 0

@export var max_health := 10
var health := max_health

# character dependent variables
@export var up := "e_up"
@export var down := "e_down"
@export var right := "e_right"
@export var left := "e_left"

@export var attack1 := "e_attack1"
@export var attack2 := "e_attack2"
@export var projectile_scene: PackedScene
@export var melee_scene: PackedScene

var xp = 0; # updated in spawn manager after each wave of enemies

func _ready() -> void:
	play()
	add_to_group("Player")

func _process(delta: float) -> void:
	# ***** MOVEMENT ******
	var dir := Input.get_vector(left, right, up, down)
	position += dir * speed * delta
	
	# ***** ATTACKS *****
	# MAY NEED COOLDOWN
	attack()

	# ***** ANIMATIONS *****
	animate(dir)

# ******************* ATTACKS **********************
# Handling key presses
func attack() -> void:
	# Regular attacks
	if Input.is_action_just_pressed(attack1):
		shoot_projectile()
	if Input.is_action_just_pressed(attack2):
		attack_melee()
	
	# Sync attacks
	if Input.is_action_pressed("e_sync") && Input.is_action_pressed("r_sync"):
		var _x = 1 # placeholder to prevent errors

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
	
	# with higher xp, can shoot 3 at once
	if xp >= 2:
		var x_change = 0.0
		var y_change = 0.0
		
		if faceDir == 0:
			x_change = -0.5
		if faceDir == 1:
			x_change = 0.5
		if faceDir == 2:
			y_change = -0.5
		if faceDir == 3:
			y_change = 0.5
		
		var projectile2 = projectile_scene.instantiate()
		var projectile3 = projectile_scene.instantiate()
		projectile2.global_position = projectile.global_position
		projectile3.global_position = projectile.global_position
		projectile2.direction = Vector2(dir.x+x_change,dir.y+y_change)
		projectile3.direction = Vector2(dir.x-x_change,dir.y-y_change)
		projectile2.rotation = dir.angle() + PI/3
		projectile3.rotation = dir.angle() + 4*PI/6
		get_tree().current_scene.add_child(projectile2)
		get_tree().current_scene.add_child(projectile3)

# spawn melee attack
func attack_melee() -> void:
	var melee = melee_scene.instantiate()
	var dir = get_facing_vector()
	
	# position slightly ahead of player and move in proper direction
	melee.global_position = global_position + dir * 30
	melee.direction = dir
	melee.rotation = dir.angle() + PI/2
	
	# given enough xp, increase size of melee
	if xp >= 5:
		melee.scale = Vector2(2,2)
	
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

# ***************** ANIMATIONS ********************
func animate(dir) -> void:
	# Determine animation based on direction
	# idle
	if dir == Vector2.ZERO:
		match faceDir:
			0: animation = "idle_up"
			1: animation = "idle_down"
			2: animation = "idle_right"
			3: animation = "idle_left"
		play()
		return
	
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

func play() -> void:
	sprite.animation = animation;
	sprite.play()
	
	if animation == "walk_down" || animation ==  "walk_up" || animation == "walk_right" || animation == "walk_left":
		if walk.playing == false:
			walk.play()
# ************************* DAMAGE ************************************
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy Attack"):
		health = health - 1
		damage_blink()
	if health < 1:
		# wait 0.5 seconds before despawning
		await get_tree().create_timer(0.5).timeout
		emit_signal("game_over")
		#queue_free()

func damage_blink():
	var tween = create_tween()
	# switch sprite between red and normal
	if health >= 1:
		tween.tween_property(sprite, "modulate", Color(1,0,0), 0.1)
		tween.tween_property(sprite, "modulate", Color(1,1,1), 0.1)
	else:
		tween.tween_property(sprite, "modulate", Color(0.286, 0.0, 0.0, 1.0), 0.1)
