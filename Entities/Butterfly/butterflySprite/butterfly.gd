extends Node2D

@onready var sprite = $Sprite
@export var speed = 300
var time = 0 # used in sin

@export var target: Node2D
@export var camera: Node2D # must stay seen by camera; otherwise gameover
var camera_x_dist = 1080 # 1080/1
var camera_y_dist = 580 # 1920/4 + 100
# which part of the screen we care the butterfly does not go beyond
@export var within_right = true
@export var within_left = true
@export var within_top = true
@export var within_bottom = true
@export var game_over := "res://Scenes/UI Scenes/DeathScene.tscn" # scene caused by being too far from the butterfly

@onready var dialog := $EmitDialogInRange
var dialog_seen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target:
		sprite.animation = "flying"
	else:
		sprite.animation = "default"
	sprite.play()
	
	# if there's no dialog, don't use a false value that turns off checks
	if !dialog:
		dialog_seen = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	
	if dialog && !dialog_seen:
		dialog_seen = dialog.dialog_already_played
	
	if target:
		var height = sin(time*4 + PI/4) * 1000 + target.global_position.y
		# butterfly rests upon finding target
		var dist = abs(global_position.x - target.global_position.x)
		print(dist)
		if dist <= 50:
			if sprite.animation == "flying":
				sprite.animation = "default"
				sprite.play()
				within_right = false
				within_left = false
				within_top = false
				within_bottom = false
		else:
			var new_pos = Vector2(target.global_position.x, height)
			global_position = global_position.move_toward(new_pos, speed*delta)
	if camera:
		var x_dist = global_position.x - camera.global_position.x
		var y_dist = global_position.y - camera.global_position.y
		
		var beyond_x = abs(x_dist) > camera_x_dist
		var beyond_y = abs(y_dist) > camera_y_dist
		
		var break_right = x_dist > 0 && within_right && beyond_x
		var break_left = x_dist < 0 && within_left && beyond_x
		var break_top = y_dist < 0 && within_top && beyond_y
		var break_bottom = y_dist > 0 && within_bottom && beyond_y 
		
		if (break_right || break_left || break_top || break_bottom) && dialog_seen:
			SceneCache.scene_change.emit(game_over)
