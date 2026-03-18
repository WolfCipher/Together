extends Node

@onready var root: Node2D = $".."

@export var prefab_a: PackedScene # Projectile
@export var prefab_b: PackedScene # AoE
@export var prefab_c: PackedScene # Shadow Elvyria
@export var prefab_d: PackedScene # Shadow Ryl
#@export var prefab_e: PackedScene
@export var spawn_positions: Array[Vector2] = [Vector2(200, 0), Vector2(400,0), Vector2(600,0), Vector2(800,0)] # predefined locations that enemies can spawn at

# each outer element represents the wave
# each inner element represents how many enemies of a particular type (a, b, c, etc.) are spawned in a wave
@export var waves: Array = [
	[1,0,0,0], # wave 1
	[2,0,0,0], # wave 2
	[1,1,0,0], # wave 3
	[2,2,0,0], # wave 4
	[0,0,1,1] # wave 5
]

# helps with looping through the wave array and spawning the particular enemies
@onready var enemy_types: Array = [
	prefab_a, prefab_b, prefab_c, prefab_d
]

@export var target1: Node2D
@export var target2: Node2D

var waveNum = 0

func _ready():
	# instantiate first wave
	spawn()

func _process(delta: float) -> void:
	# if current wave is over (all enemies are defeated, so self has no children), start new wave
	if self.get_child_count() == 0:
		# TODO handle finishing level
		if waveNum >= waves.size():
			return
		else:
			target1.xp += 1
			target2.xp += 1
			spawn()

func spawn() -> void:
	# which spawn location to use
	var index = 0
	
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
			enemy.global_position = spawn_positions[index]
			self.add_child(enemy)
			
			index = (index + 1) % spawn_positions.size() # go to next position for instantiation
	
	waveNum += 1
