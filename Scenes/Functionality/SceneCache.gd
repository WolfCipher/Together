extends Node

var level1 : PackedScene
var dialog1 : PackedScene
var level2 : PackedScene
var level3 : PackedScene
var gameover : PackedScene

var curr_level : String

signal scene_change(next_scene)
signal create_dialog(character, emotion, text, duration)
