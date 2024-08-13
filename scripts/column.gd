extends Node2D

var circles := [] # Array of circles in column
var circle_index := 0 # How many circles have been placed

signal column_clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	circles = get_children().slice(1) # Gets references to the circles without the collision area

func _on_area_2d_input_event(viewport, event, shape_idx):
	if InputEventMouseButton:
		if event.is_pressed():
			column_clicked.emit(self)
			
func place_circle(colour : String):
	if circle_index > 5: return false
	circles[circle_index].activate(colour)
	circle_index += 1
	return true
		
func get_circle(index : int):
	if index < circles.size():
		return circles[index]
