extends Node2D

@export var player1 : Node2D
@export var player2 : Node2D

@export var projectile1 : PackedScene
@export var projectile2 : PackedScene

# how close the players must be
@export var sync_distance := 20000.0
# how often players can use the sync attack
@export var sync_recharge := 10.0
var sync_cooldown := 0.0

# determine what x and y projectiles should start at
var min_x
var max_x
var min_y
var max_y


# start between the characters
func _ready() -> void:
	center()

func _process(delta: float) -> void:
	center() # stay between the players
	
	sync_cooldown -= delta
	
	var in_sync = Input.is_action_pressed("e_sync") && Input.is_action_pressed("r_sync")
	var nearby = player1.position.distance_squared_to(player2.position) <= sync_distance
	
	if in_sync && nearby && sync_cooldown <= 0:
		shoot_projectile(Vector2(0,1), projectile1)
		shoot_projectile(Vector2(0,1), projectile2)
		shoot_projectile(Vector2(0,-1), projectile1)
		shoot_projectile(Vector2(0,-1), projectile2)
		shoot_projectile(Vector2(1,0), projectile1)
		shoot_projectile(Vector2(1,0), projectile2)
		shoot_projectile(Vector2(-1,0), projectile1)
		shoot_projectile(Vector2(-1,0), projectile2)
		
		shoot_projectile(Vector2(0.75,0.75), projectile1)
		shoot_projectile(Vector2(0.75,0.75), projectile2)
		shoot_projectile(Vector2(0.75,-0.75), projectile1)
		shoot_projectile(Vector2(0.75,-0.75), projectile2)
		shoot_projectile(Vector2(-0.75,0.75), projectile1)
		shoot_projectile(Vector2(-0.75,0.75), projectile2)
		shoot_projectile(Vector2(-0.75,-0.75), projectile1)
		shoot_projectile(Vector2(-0.75,-0.75), projectile2)
		
		sync_cooldown = sync_recharge

# Spawn projectiles
func shoot_projectile(dir, projectile_scene) -> void:
	var projectile = projectile_scene.instantiate()
	
	# position slightly ahead of players and move in proper direction
	projectile.global_position = global_position + dir * 30
	projectile.direction = dir
	projectile.rotation = dir.angle() + PI/2
	
	# spawn
	get_tree().current_scene.add_child(projectile)

# stay between the characters
func center() -> void:
	var pos1 = player1.global_position
	var pos2 = player2.global_position
	var x = (pos1.x + pos2.x)/2
	var y = (pos1.y + pos2.y)/2
	var target_pos = Vector2(x,y)
	
	global_position = target_pos
	
	# TODO should probably make relative to global_position
	min_x = min(pos1.x, pos2.x)
	max_x = max(pos1.x, pos2.x)
	min_y = min(pos1.y, pos2.y)
	max_y = max(pos1.y, pos2.y)
