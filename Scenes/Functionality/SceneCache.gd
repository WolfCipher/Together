extends Node

var level1 : PackedScene
var dialog1 : PackedScene
var level2 : PackedScene
var dialog2 : PackedScene
var level3 : PackedScene
var dialog3 : PackedScene
var level4 : PackedScene
var dialog4 : PackedScene
var dialog5 : PackedScene
var gameover : PackedScene

var curr_level : String

signal scene_change(next_scene)
signal create_dialog(character, emotion, text, duration)
signal create_fog(to_fade_in, to_fade_out)
