extends Node2D

var dialog_already_played = false # ensures this only plays once
@export var dialog_list: Array = [
	["ryl", 0, "What's the Dullworld?",7],
	["elvyria", 0, "...This world.",5],
	["ryl", 0, "...",3]
]

@export var send_to_scene_after_completion = false
@export var next_scene = "res://Scenes/UI Scenes/Victory.tscn"

@export var waiting_for_butterfly = false
var num_players = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Player")):
		num_players += 1
		if !dialog_already_played && !waiting_for_butterfly:
			dialog_already_played = true
			play_dialog()
	if(area.is_in_group("Butterfly")):
		waiting_for_butterfly = false
		if !dialog_already_played && num_players > 0:
			dialog_already_played = true
			play_dialog()

func play_dialog():
	for i in dialog_list.size():
		SceneCache.create_dialog.emit(dialog_list[i][0], dialog_list[i][1], dialog_list[i][2], dialog_list[i][3])
		await get_tree().create_timer(2).timeout
	
	if send_to_scene_after_completion:
		SceneCache.scene_change.emit(next_scene)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if(area.is_in_group("Player")):
		num_players -= 1
