extends Button

@export var next_scene : PackedScene
@onready var btn_click = AudioStreamPlayer.new()
@onready var btn_hover = AudioStreamPlayer.new()

var click_sfx = preload("res://Sound/SFX/UI_Sounds/Button_Select/Button_Select_1.wav")
var hover_sfx = preload("res://Sound/SFX/UI_Sounds/Button_Hover/Button_Hover_1.wav")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	btn_click.stream = click_sfx
	btn_hover.stream = hover_sfx
	add_child(btn_click)
	add_child(btn_hover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_pressed() && !btn_click.playing:
		btn_click.play()
		get_tree().change_scene_to_packed(next_scene)
	if is_hovered() && !btn_hover.playing:
		btn_hover.play()
