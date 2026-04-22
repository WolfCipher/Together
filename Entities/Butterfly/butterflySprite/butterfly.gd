extends Node2D

@onready var sprite = $Sprite
@export var speed = 200
var time = 0 # used in sin

@export var target: Node2D
@export var camera: Node2D # must stay seen by camera; otherwise gameover
var camera_x_dist = 1080 # 1080/1
var camera_y_dist = 580 # 1920/4 + 100
@export var game_over := "res://Scenes/UI Scenes/DeathScene.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target:
		sprite.animation = "flying"
	else:
		sprite.animation = "default"
	sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var height = sin(time*4 + PI/4) * 1000
	
	if target:
		# butterfly rests upon finding target
		if global_position.x == target.global_position.x && sprite.animation == "flying":
			sprite.animation = "default"
			sprite.play()
		else:
			var new_pos = Vector2(target.global_position.x, height)
			global_position = global_position.move_toward(new_pos, speed*delta)
	if camera:
		var x_dist = abs(global_position.x - camera.global_position.x)
		var y_dist = abs(global_position.y - camera.global_position.y)
		
		if (x_dist > camera_x_dist || y_dist > camera_y_dist):
			SceneCache.scene_change.emit(game_over)
