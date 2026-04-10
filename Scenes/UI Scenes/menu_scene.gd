extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneCache.level1 = preload("res://Scenes/Levels/level1.tscn")
	SceneCache.dialog1 = preload("res://Ink/Scenes/ink_scene.tscn")
	SceneCache.level2 = preload("res://Scenes/Levels/level2.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
