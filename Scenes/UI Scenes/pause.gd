extends Control

@export var startsVisible = false # only level 1 is true
var volume_change = .4
var sfx_volume = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))
var sfx_index = AudioServer.get_bus_index("SFX")
var music_volume = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Music"))
var music_index = AudioServer.get_bus_index("Music")
var first_play = startsVisible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = startsVisible
	if startsVisible:
		get_tree().paused = true
		await get_tree().create_timer(2.0).timeout
		AudioServer.set_bus_volume_linear(music_index, volume_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	if Input.is_action_just_released("pause"):
		if get_tree().paused == false:
			visible = true
			get_tree().paused = true
			fade_in_music()
			AudioServer.set_bus_volume_linear(sfx_index, 0)
			await get_tree().create_timer(2.0).timeout
		else:
			visible = false
			get_tree().paused = false
			fade_out_music()
			AudioServer.set_bus_volume_linear(sfx_index, sfx_volume)
			await get_tree().create_timer(2.0).timeout
			
func on_scene_change(next_scene):
	get_tree().paused = false
	free()
	
func fade_in_music() -> void:
	var fade = create_tween()
	fade.tween_method(func(vol): AudioServer.set_bus_volume_linear(music_index, vol), music_volume, volume_change, 1.0)
	
func fade_out_music() -> void:
	var fade = create_tween()
	fade.tween_method(func(vol): AudioServer.set_bus_volume_linear(music_index, vol), volume_change, music_volume, 1.0)
