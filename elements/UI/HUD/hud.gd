extends CanvasLayer


func _on_home_button_pressed():
	Events.location_changed.emit(Events.LOCATIONS.START)

@onready var knives_counter = Hud.get_node("MarginContainer/VBoxContainer/HBoxContainer2/KnivesCounter")
@onready var home_button := Hud.get_node("MarginContainer/VBoxContainer/HBoxContainer/HomeButton")
@onready var points_label := Hud.get_node("MarginContainer/VBoxContainer/HBoxContainer/PointsLabel")
@onready var stage_counter := Hud.get_node("MarginContainer/VBoxContainer/HBoxContainer/StageCounter")
@onready var stage_label := Hud.get_node("MarginContainer/VBoxContainer/StageLabel")


func _ready():
	Events.location_changed.connect(update_hud_location)
	Events.points_changed.connect(update_points)
	update_hud_location(Events.LOCATIONS.START)


func _on_button_pressed():
	Events.location_changed.emit(Events.LOCATIONS.GAME)

func update_points(points: int):
	points_label.text = str(points)
	


func _on_texture_button_pressed():
	Events.location_changed.emit(Events.LOCATIONS.SHOP)

func update_hud_location(location: Events.LOCATIONS):
	match location:
		Events.LOCATIONS.START:
			knives_counter.hide()
			home_button.hide()
			points_label.hide()
			stage_label.hide()
			stage_counter.hide()
		Events.LOCATIONS.GAME:
			knives_counter.show()
			home_button.show()
			points_label.show()
			stage_label.show()
			stage_counter.show()
		Events.LOCATIONS.SHOP:
			knives_counter.hide()
			home_button.show()
			points_label.hide()
			stage_label.hide()
			stage_counter.hide()


func update_hud_restart():
	knives_counter.hide()
	home_button.show()
	points_label.hide()
	stage_label.hide()
	stage_counter.hide()
