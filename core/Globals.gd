extends Node

const location_to_scene = {
	Events.LOCATIONS.GAME: preload('res://scenes/game.tscn'),
	Events.LOCATIONS.START: preload("res://scenes/start_screen/start_screen.tscn"),
	Events.LOCATIONS.SHOP: preload('res://scenes/knife_store/knife_shop.tscn')
	
}

const MAX_STAGE_APPLES := 7
const MAX_STAGE_KNIVES := 3
const MIN_KNIVES := 4 
const MAX_KNIVES := 9

var rng := RandomNumberGenerator.new()

var points := 0
var knives := 0
var apples := 0
var current_stage := 1


func add_apples(amount: int):
	apples += amount
	Events.apples_changed.emit(apples)
	

func remove_knife():
	knives -= 1
	Events.knives_changed.emit(knives)


func get_common_stage() -> Stage:
	var stage := Stage.new()
	stage.apples = rng.randi_range(0, MAX_STAGE_APPLES)
	stage.knives = rng.randi_range(0, MAX_STAGE_KNIVES)
	
	return stage

func change_stage(stage_i: int):
	current_stage = stage_i
	var stage := get_common_stage()
	knives = rng.randi_range(MIN_KNIVES, MAX_KNIVES)
	Events.knives_changed.emit(knives)
	Events.stage_changed.emit(stage)
func _ready():
	rng.randomize()
	print_debug(rng.seed)
	
	Events.location_changed.connect(handle_location_change)
func add_point():
	points += 1
	Events.points_changed.emit(points)

func reset_points():
	points = 0
	Events.points_changed.emit(points)


func handle_location_change(location: Events.LOCATIONS):
	get_tree().change_scene_to_packed(location_to_scene.get(location))
	
