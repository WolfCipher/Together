extends Node2D

@onready var ctn_btn = $Continue
@onready var start_btn = $Start
@onready var inst_btn = $Instructions



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_btn.grab_focus()
	
	if (SceneCache.curr_level):
		ctn_btn.disabled = false
	
	SceneCache.level1 = preload("res://Scenes/Levels/level1.tscn")
	SceneCache.dialog1 = preload("res://Ink/Scenes/ink_scene.tscn")
	SceneCache.level2 = preload("res://Scenes/Levels/level2.tscn")
	SceneCache.dialog2 = preload("res://Ink/Scenes/vyerity_dialog.tscn")
	SceneCache.level3 = preload("res://Scenes/Levels/level3.tscn")
	SceneCache.gameover = preload("res://Scenes/UI Scenes/DeathScene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
