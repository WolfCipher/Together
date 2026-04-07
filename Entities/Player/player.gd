extends Area2D

@export var game_over := "res://Scenes/UI Scenes/DeathScene.tscn"

@onready var root: Node2D = $".."
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation := sprite.animation
@onready var walk: AudioStreamPlayer = $AudioStreamPlayer


@export var speed = 400
# 0=up, 1=down, 2=right, 3=left; lets idle animations face the right direction
@export var faceDir = 0

@export var max_health := 10
var health := max_health

# limiting how how different attacks can be used
@export var shoot_recharge := 0.5
@export var melee_recharge := 0.0
@export var sync_recharge := 10.0
@export var dash_recharge := 2
@export var shield_recharge := 10

var shoot_cooldown := 0.0
var melee_cooldown := 0.0
var sync_cooldown := 0.0
var dash_cooldown := 0.0
var shield_cooldown := 0.0

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

var god_mode = false; # makes player invincible when shift + quote tilde pressed

var invulnerable = false; # makes player invulnerable for game play


# can_move false if hits at least one boundary in the corresponding direction
var can_move_up = true
var can_move_down = true
var can_move_right = true
var can_move_left = true
var num_left_boundaries = 0
var num_right_boundaries = 0
var num_bottom_boundaries = 0
var num_top_boundaries = 0

func _ready() -> void:
	play()
	add_to_group("Player")

func _process(delta: float) -> void:
	recharge(delta)
	
	# ***** MOVEMENT ******
	var dir := Input.get_vector(left, right, up, down)
	
	# lets us look like we're walking into things by sending dir to animation
	# but we can't move through things by using move_dir for position
	var move_dir = dir
	
	if !can_move_up && dir.y < 0:
		move_dir.y = 0
	if !can_move_down && dir.y > 0:
		move_dir.y = 0
	if !can_move_right && dir.x > 0:
		move_dir.x = 0
	if !can_move_left && dir.x < 0:
		move_dir.x = 0
	
	position += move_dir * speed * delta
	
	# ***** ATTACKS *****
	# MAY NEED COOLDOWN
	attack()
	
	# ***** Abilities *****
	dash()
	shield()
	
	# ***** ANIMATIONS *****
	animate(dir)
	
	# ***** GOD MODE *****
	god()

# ******************* ATTACKS **********************
func recharge(delta):
	shoot_cooldown -= delta
	melee_cooldown -= delta
	sync_cooldown -= delta
	dash_cooldown -= delta
	shield_cooldown -= delta

# Handling key presses
func attack() -> void:
	# Regular attacks
	if Input.is_action_just_pressed(attack1):
		if shoot_cooldown <= 0:
			shoot_projectile()
			shoot_cooldown = shoot_recharge
	if Input.is_action_just_pressed(attack2):
		if melee_cooldown <= 0:
			attack_melee()
			melee_cooldown = melee_recharge
	
	# Sync attacks HANDLED IN SYNC.GD
	#if Input.is_action_pressed("e_sync") && Input.is_action_pressed("r_sync"):
	#	var _x = 1 # placeholder to prevent errors

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
	melee.global_position = global_position + dir * 60
	melee.rotation = dir.angle() + PI/2
	
	# given enough xp, increase size of melee
	if xp >= 5:
		melee.scale = Vector2(2,2)
	
	# spawn
	get_tree().current_scene.add_child(melee)
	
# allows ryl to dash
func dash() -> void:
	if Input.is_action_just_pressed("r_dash") and is_in_group('Ryl') and dash_cooldown <= 0:
		dash_cooldown = dash_recharge
		speed = 1000
		print("dash!!!")
		await get_tree().create_timer(0.25).timeout
		speed = 400
		
# allows Elvyria to shield
func shield() -> void:
	if Input.is_action_just_pressed("e_shield") and is_in_group('Elvyria') and shield_cooldown <= 0:
		var tween = create_tween()
		print("shield!!!")
		shield_cooldown = shield_recharge
		speed = 250
		tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 0.0, 1.0), 0.1)
		invulnerable = true
		await get_tree().create_timer(1.6).timeout
		speed = 400
		tween.kill()
		invulnerable = false

# Gives the direction the player is facing
# Ensures attacks go in the correct direction
func get_facing_vector() -> Vector2:
	match faceDir:
		0: return Vector2(0,-1)
		1: return Vector2(0,1)
		2: return Vector2(1,0)
		3: return Vector2(-1,0)
	return Vector2.ZERO
	
func god():
	if Input.is_action_just_pressed('dev_key'):
		god_mode = not god_mode
		print("God Mode Toggled!")

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
	
# ***************** SOUNDS ********************
	if animation == "walk_down" || animation ==  "walk_up" || animation == "walk_right" || animation == "walk_left":
		if walk.playing == false:
			walk.play()

# ************************* DAMAGE & COLLISION ************************************
func damage_blink():
	var tween = create_tween()
	# switch sprite between red and normal
	if health >= 1:
		tween.tween_property(sprite, "modulate", Color(1,0,0), 0.1)
		tween.tween_property(sprite, "modulate", Color(1,1,1), 0.1)
	else:
		tween.tween_property(sprite, "modulate", Color(0.286, 0.0, 0.0, 1.0), 0.1)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy Attack") and god_mode == false and invulnerable == false:
		health = health - area.damage
		damage_blink()
		if health < 1:
			# prevent retriggering _on_area_entered once all physics calculations finish, thereby avoiding null data.tree issues
			$CollisionShape2D.set_deferred("disabled", true)
			
			# wait 0.5 seconds before despawning
			await get_tree().create_timer(0.5).timeout
			#get_tree().change_scene_to_file(game_over)
			SceneCache.scene_change.emit(game_over)
			#queue_free()
	else:
		if area.is_in_group("BoundaryLeft"):
			can_move_left = false
			num_left_boundaries += 1
		elif area.is_in_group("BoundaryRight"):
			can_move_right = false
			num_right_boundaries += 1
		elif area.is_in_group("BoundaryTop"):
			can_move_up = false
			num_top_boundaries += 1
		elif area.is_in_group("BoundaryBottom"):
			can_move_down = false
			num_bottom_boundaries += 1

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("BoundaryLeft"):
		num_left_boundaries -= 1
		if (num_left_boundaries == 0):
			can_move_left = true
	elif area.is_in_group("BoundaryRight"):
		num_right_boundaries -= 1
		if (num_right_boundaries == 0):
			can_move_right = true
	elif area.is_in_group("BoundaryTop"):
		num_top_boundaries -= 1
		if (num_top_boundaries == 0):
			can_move_up = true
	elif area.is_in_group("BoundaryBottom"):
		num_bottom_boundaries -= 1
		if (num_bottom_boundaries == 0):
			can_move_down = true
