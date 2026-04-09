extends Node2D

var dialog_already_played = false # ensures this only plays once
@export var dialog_list: Array = [
	["ryl", 0, "What's the Dullworld?",5],
	["elvyria", 0, "...This world.",3]
]

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Player") && !dialog_already_played):
		dialog_already_played = true
		play_dialog()

func play_dialog():
	for i in dialog_list.size():
		SceneCache.create_dialog.emit(dialog_list[i][0], dialog_list[i][1], dialog_list[i][2], dialog_list[i][3])
		await get_tree().create_timer(2).timeout
