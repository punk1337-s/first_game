extends CharacterBody2D

class_name Target


const explosion_time := 1.0
const knife_position = Vector2(0, 180)
const apple_position = Vector2(0, 176)
const object_margin := PI / 6
const generation_limit := 10

var knife_scene : PackedScene = load("res://elements/knives/knife.tscn")
var apple_scene : PackedScene = load("res://apple/node_2d.tscn")

var speed := PI

@onready var items_container := $items_container
@onready var sprite := $Target1
@onready var knife_particles := $knifeParticles2D
@onready var particles_target_parts := [
	$targetParticles2D,
	$targetParticles2D2,
	$targetParticles2D3
]


func explode():
	sprite.hide()
	items_container.hide()
	
	var tween := create_tween()
	
	for particles_target_part in particles_target_parts:
		tween.parallel().tween_property(particles_target_part, "modulate", Color("ffffff00"), explosion_time)
		particles_target_part.emitting = true
	knife_particles.rotation = -rotation
	knife_particles.emitting = true
	tween.parallel().tween_property(knife_particles, "modulate", Color("ffffff00"), explosion_time)
	
	tween.play()
	await tween.finished
	Globals.change_stage(Globals.current_stage + 1)

func take_damage():
	if Globals.knives == 0:
		explode()
	


func _physics_process(delta: float):
	rotation += speed * delta

func add_object_with_pivot(object: Node2D, object_rotation: float):
	var pivot := Node2D.new()
	pivot.rotation = object_rotation
	pivot.add_child(object)
	items_container.add_child(pivot)

func add_default_items(knives: int, apples: int):
	var occupied_rotations := []
	for i in range(knives):
		var pivot_rotations = get_free_random_ratations(occupied_rotations)
		if pivot_rotations == null:
			return
		occupied_rotations.append(pivot_rotations)
		var knife = knife_scene.instantiate()
		knife.position = knife_position
		add_object_with_pivot(knife, pivot_rotations)
	for i in range(apples):
		var pivot_rotations = get_free_random_ratations(occupied_rotations)
		if pivot_rotations == null:
			return
		occupied_rotations.append(pivot_rotations)
		var apple = apple_scene.instantiate()
		apple.position = apple_position
		add_object_with_pivot(apple, pivot_rotations)

func get_free_random_ratations(occupied_rotations: Array, generation_attempts = 0):
	if generation_attempts >= generation_limit:
		return null
	
	var random_rotation = Globals.rng.randf_range(0, PI * 2)
	
	for occupied in occupied_rotations:
		if random_rotation <= occupied + object_margin / 2.0 and random_rotation >= occupied - object_margin / 2.0:
			return get_free_random_ratations(occupied_rotations, generation_attempts + 1)
		
	
	return random_rotation
