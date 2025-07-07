extends Node2D

var is_hitted := false

const explosion_time := 1.0

@onready var particles := [
	$appleParticles2D,
	$appleParticles2D2
]

@onready var sprite := $Apple1

func _on_area_2d_body_entered(body):
	if not is_hitted:
		is_hitted = true
		sprite.hide()
		var tween = create_tween()
		for particle in particles:
			particle.emitting = true
			tween.parallel().tween_property(particle, "modulate", Color("ffffff00"), explosion_time)
		
		
		tween.play()
		await tween.finished
		queue_free()
