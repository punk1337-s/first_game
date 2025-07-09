extends RefCounted
class_name Stage

var knives := 0
var apples := 0
var taget_scene_resource : PackedScene

func _init(_target_scene = preload("res://elements/targets/target/target.tscn")):
	taget_scene_resource = _target_scene
