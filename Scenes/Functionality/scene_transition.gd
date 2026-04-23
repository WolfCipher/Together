extends Node2D

@export var fade_in = true
@export var fade_out = true
@onready var color_rect = $ColorRect

func _ready() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE # doesn't absorb clicks; allows clicks to go through to buttons
	SceneCache.scene_change.connect(on_scene_change)
	
	color_rect.color = Color(0,0,0,1)
	visible = true
	var time = 0
	
	if fade_in:
		time = 0.4
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(0,0,0,0), time)

func on_scene_change(next_scene):
	
	if (next_scene.contains("level")):
		SceneCache.curr_level = next_scene
	
	if fade_out:
		var tween = create_tween()
		tween.tween_property(color_rect, "modulate", Color(0,0,0,1), 0.4)
		await get_tree().create_timer(0.4).timeout
	
	# must check if tree is null to avoid certain errors (like both players calling game over causing null errors)
	var tree = get_tree()
	if (tree):
		tree.change_scene_to_file(next_scene)
