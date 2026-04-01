extends AnimatedSprite2D

@export var player1 : Node2D
@export var player2 : Node2D

@export var projectile1 : PackedScene
@export var projectile2 : PackedScene

# how close the players must be
@export var sync_distance := 20000.0
# the frame rate --- how often players can use the sync attack
# there are 10 frames, so the total number of seconds recharge takes is 10*sync_recharge
# TODO enable items to upgrade recharge rate
@export var sync_recharge := 1.0
var last_frame = sprite_frames.get_frame_count("default") - 1 # final frame

# TODO determine what x and y projectiles should start at
var min_x
var max_x
var min_y
var max_y
var my_global_position


# start between the characters
func _ready() -> void:
	center()
	sprite_frames.set_animation_speed("default", sync_recharge) # frame rate
	frame = last_frame # start with full gauge

func _process(_delta: float) -> void:
	center() # stay between the players
	
	if (frame == last_frame):
		pause()
	
	# TODO make c'mon! sounds when only one player presses SHIFT
	
	var in_sync = Input.is_action_pressed("e_sync") && Input.is_action_pressed("r_sync")
	var nearby = player1.position.distance_squared_to(player2.position) <= sync_distance
	
	if in_sync && nearby && frame >= 10: # 10th frame is full but not necessarily the final frame; don't use last_frame here
		shoot_projectile(Vector2(0,1), projectile1)
		shoot_projectile(Vector2(0,1), projectile2)
		shoot_projectile(Vector2(0,-1), projectile1)
		shoot_projectile(Vector2(0,-1), projectile2)
		shoot_projectile(Vector2(1,0), projectile1)
		shoot_projectile(Vector2(1,0), projectile2)
		shoot_projectile(Vector2(-1,0), projectile1)
		shoot_projectile(Vector2(-1,0), projectile2)
		
		shoot_projectile(Vector2(1,1).normalized(), projectile1)
		shoot_projectile(Vector2(1,1).normalized(), projectile2)
		shoot_projectile(Vector2(1,-1).normalized(), projectile1)
		shoot_projectile(Vector2(1,-1).normalized(), projectile2)
		shoot_projectile(Vector2(-1,1).normalized(), projectile1)
		shoot_projectile(Vector2(-1,1).normalized(), projectile2)
		shoot_projectile(Vector2(-1,-1).normalized(), projectile1)
		shoot_projectile(Vector2(-1,-1).normalized(), projectile2)
		
		frame = 0
		play()

# Spawn projectiles
func shoot_projectile(dir, projectile_scene) -> void:
	var projectile = projectile_scene.instantiate()
	
	# position slightly ahead of players and move in proper direction
	projectile.global_position = my_global_position + dir * 30
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
	
	my_global_position = target_pos
	
	# TODO should probably make relative to global_position
	min_x = min(pos1.x, pos2.x)
	max_x = max(pos1.x, pos2.x)
	min_y = min(pos1.y, pos2.y)
	max_y = max(pos1.y, pos2.y)
