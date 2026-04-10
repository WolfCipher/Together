extends Node2D

@onready var video: VideoStreamPlayer = $VideoStreamPlayer
@onready var skipLabel: Label = $Label
@onready var hideTimer: Timer = $HideTimer
@onready var anim: AnimationPlayer = $AnimationPlayer

@export var next_scene : String
@export var skip_input : String = "spacebar"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("web"):
		# ffmpeg has no support for web right now, so skip cutscene
		_endCutscene()
	else:
		# allows us to decode video file in Godot, which needs ffmpeg
		var ffmpeg = ClassDB.instantiate("FFmpegVideoStream")
		if ffmpeg:
			ffmpeg.file = "res://Cutscenes/TogetherIntroductionCompressed.mp4"
			$VideoStreamPlayer.stream = ffmpeg
	
	skipLabel.visible = false
	video.play()
	video.finished.connect(_onFinish)
	anim.animation_finished.connect(_on_animation_finished)

# Called when any button is pressed
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if skipLabel.visible and event.is_action_pressed(skip_input):
			_endCutscene()
		else:
			_showLabel()

func _showLabel():
	# ensure skip label is fully visible
	skipLabel.visible = true
	skipLabel.modulate.a = 1.0
	# hide label after a certain time
	hideTimer.start()

func _on_HideTimer_timeout():
	# play fade-out animation
	anim.play("fade_out")

func _on_animation_finished(anim_name):
	# reset visibility to false
	if anim_name == "fade_out":
		skipLabel.visible = false

func _onFinish():
	_endCutscene()
	
func _endCutscene():
	if next_scene:
		#get_tree().change_scene_to_file(next_scene)
		SceneCache.scene_change.emit(next_scene)
	else:
		push_warning("No next_scene assigned!")
