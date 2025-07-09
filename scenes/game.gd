extends Node2D

var restart_overlay_scene := preload('res://elements/UI/restart/restart_overlay.tscn')

@onready var knife_shooter := $knifeshooter
@onready var taget_position := $TargetPosition

var Target

func _ready():
	Events.game_over.connect(end_game)
	Events.stage_changed.connect(place_target)
	Globals.change_stage(1)
	

func place_target(stage: Stage):
	if Target:
		Target.queue_free()
	Target = stage.taget_scene_resource.instantiate()
	add_child(Target)
	Target.add_default_items(stage.knives, stage.apples)
	Target.global_position = taget_position.global_position

func end_game():
	knife_shooter.is_enabled = false
	show_restart_overlay()
	Globals.reset_points()


func show_restart_overlay():
	add_child(restart_overlay_scene.instantiate())
	Hud.update_hud_restart()
