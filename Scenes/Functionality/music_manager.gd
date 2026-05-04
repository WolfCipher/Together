extends Node

@onready var battle_music: AudioStreamPlayer = $BattleMusic
@onready var village_music: AudioStreamPlayer = $VillageMusic
@onready var forest_ambient: AudioStreamPlayer = $ForestAmbient
@onready var victory_music: AudioStreamPlayer = $VictoryMusic
@onready var death_music: AudioStreamPlayer = $DeathMusic
@onready var menu_music: AudioStreamPlayer = $MenuMusic

@onready var music_bus_index = AudioServer.get_bus_index("Music")
@onready var curr_track: AudioStreamPlayer
@onready var first_play = true
@onready var curr_track_def_vol = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_track = battle_music
	curr_track_def_vol = .8
		
	print(SceneCache.curr_level)
	if SceneCache.curr_level.contains("res://Scenes/Levels/"):
		curr_track = battle_music
		curr_track_def_vol = .8
	
	# Gets music for dialogue scenes
	if get_node_or_null("../../Ink Manager"):
		curr_track = village_music
		curr_track_def_vol = curr_track.volume_linear
		
	if get_node_or_null("../../Level2"):
		curr_track = village_music
		curr_track_def_vol = curr_track.volume_linear
		
	# Gets music for end screen
	if get_node_or_null("../../Victory"):
		curr_track = victory_music
		curr_track_def_vol = curr_track.volume_linear
	
	# Gets music for DeathScene
	if get_node_or_null("../../DeathScene"):
		curr_track = death_music
		curr_track_def_vol = curr_track.volume_linear
		
	#Gets music for main menu
	if get_node_or_null("../../MenuScene"):
		curr_track = menu_music
		curr_track_def_vol = curr_track.volume_linear

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if first_play && curr_track:
		curr_track.volume_linear = 0
		var fade_in = create_tween()
		fade_in.tween_property(curr_track,"volume_linear", curr_track_def_vol, 5.0)
		curr_track.play()
		first_play = false
	
	if curr_track && !curr_track.playing && !first_play:
		curr_track.play()
		print("Now Playing: ", curr_track)
	
func switch_track(FirstTrack: AudioStreamPlayer, SecondTrack: AudioStreamPlayer) -> void:
	var tween = create_tween()
	#curr_vol = AudioServer.get_bus_index("Music")
	tween.tween_property(FirstTrack,"volume_linear", 0.0, 5.0)
	tween.play()
	
	SecondTrack.volume_linear = 0
	SecondTrack.play()
	curr_track = SecondTrack
	print("Now Playing: ", curr_track)
	tween.chain().tween_property(SecondTrack,"volume_linear", 1.0, 5.0)
	tween.play()
	
