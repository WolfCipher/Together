extends Button

@onready var btn_click: AudioStreamPlayer = $BtnClick
@onready var btn_hover: AudioStreamPlayer = $BtnHover
var hover_playing = false
var focused = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_pressed() && !btn_click.playing:
		btn_click.play()
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
