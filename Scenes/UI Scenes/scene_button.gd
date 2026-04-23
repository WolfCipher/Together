extends Button

@export var next_scene : String   
@export var return_to_last_level = false # only true for continuing the game
@onready var btn_click = AudioStreamPlayer.new()
@onready var btn_hover = AudioStreamPlayer.new()

var click_sfx = preload("res://Sound/SFX/UI_Sounds/Button_Select/UI_Click_1.wav")
var hover_sfx = preload("res://Sound/SFX/UI_Sounds/Button_Hover/UI_Hover_1.wav")

var hover_playing = false
var focused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_click.stream = click_sfx
	btn_hover.stream = hover_sfx
	add_child(btn_click)
	add_child(btn_hover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_pressed() && !btn_click.playing:
		btn_click.play()
		#get_tree().change_scene_to_file(next_scene)
		if (return_to_last_level):
			SceneCache.scene_change.emit(SceneCache.curr_level)
		else:
			SceneCache.scene_change.emit(next_scene)
	if is_hovered() && !hover_playing && !disabled:
		hover_playing = true
		btn_hover.play()
	if !is_hovered():
		hover_playing = false
	if has_focus() && !focused:
		focused = true
		btn_hover.play()
	if !has_focus():
		focused = false
