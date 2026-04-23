extends Control

@export var startsVisible = false # only level 1 is true
var volume_change = 10
@onready var music = $"../../CoreLoop"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = startsVisible
	if startsVisible:
		get_tree().paused = true
		if music:
			music.volume_db -= volume_change
		await get_tree().create_timer(2.0).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("pause"):
		if get_tree().paused == false:
			visible = true
			get_tree().paused = true
			if music:
				music.volume_db -= volume_change
			await get_tree().create_timer(2.0).timeout
		else:
			visible = false
			get_tree().paused = false
			if music:
				music.volume_db += volume_change
			await get_tree().create_timer(2.0).timeout
