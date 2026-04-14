extends Node

@onready var root: Node2D = $".."

@export var prefab_a: PackedScene # Projectile
@export var prefab_b: PackedScene # AoE
@export var prefab_c: PackedScene # Contact
@export var prefab_d: PackedScene # Shadow Elvyria
@export var prefab_e: PackedScene # Shadow Ryl
@export var spawn_positions: Array[Vector2] = [Vector2(750, 500), Vector2(250,500), Vector2(540,200), Vector2(540,700)] # predefined locations that enemies can spawn at
var pos_index = 0
@export var next_scene : String
@export var goes_to_next_scene = true # false if waves occur mid-scene
@export var can_start = true # false if needs another condition (eg players must reach a certain location)
@export var distance_start = 500 # distance players must be from spawn manager to set can_start = true

# each outer element represents the wave
# each inner element represents how many enemies of a particular type (a, b, c, etc.) are spawned in a wave
@export var waves: Array = [
	[0,0,1,0,0], # wave 1
	[0,1,1,0,0], # wave 2
	[0,2,0,0,0], # wave 3
	[1,1,0,0,0], # wave 4
	[2,0,0,0,0], # wave 5
	[2,2,0,0,0], # wave 6
	[1,1,1,0,0], # wave 7
	[0,0,0,1,1], # wave 8
	[1,1,0,1,1], # wave 9
	[0,0,0,2,2], # wave 10
]

# helps with looping through the wave array and spawning the particular enemies
@onready var enemy_types: Array = [
	prefab_a, prefab_b, prefab_c, prefab_d, prefab_e
]

@export var target1: Node2D
@export var target2: Node2D

var waveNum = 0

func _ready():
	# instantiate first wave
	if can_start:
		spawn()

func _process(_delta: float) -> void:
	if can_start:
		# if current wave is over (all enemies are defeated, so self has no children), start new wave
		if self.get_child_count() == 0:
			# TODO handle finishing level
			if waveNum >= waves.size():
				if next_scene:
					await get_tree().create_timer(1.0).timeout # wait 0.2 seconds before changing scene
					#get_tree().change_scene_to_file(next_scene)
					SceneCache.scene_change.emit(next_scene)
				return
			else:
				target1.xp += 1
				target2.xp += 1
				spawn()
	else:
		var pos1 = target1.global_position
		var pos2 = target2.global_position
		var dist1 = self.global_position.distance_to(pos1)
		var dist2 = self.global_position.distance_to(pos2)
		
		if (dist1 <= distance_start || dist2 <= distance_start):
			can_start = true

func spawn() -> void:
	# which spawn location to use
	
	var wave = waves[waveNum]
	
	# go through each enemy type
	for i in wave.size():
		# create as many enemies of that type as needed
		for j in range(wave[i]):
			var enemy = enemy_types[i].instantiate()
			
			# set players as targets
			# Note: all other variables can be set in the tscn itself
			enemy.target1 = target1
			enemy.target2 = target2
			
			# choose location and add enemy to spawn manager
			# wave is over once all enemies are dequeued from the spawn manager
			enemy.global_position = spawn_positions[pos_index]
			self.add_child(enemy)
			
			pos_index = (pos_index + 1) % spawn_positions.size() # go to next position for instantiation
	
	waveNum += 1
