extends Node2D

const AVAILABLE_COLOURS = {
	"RED": Color(1,0,0),
	"BLUE": Color(0,0,1)
}

var this_colour : String

func activate(colour : String):
	if colour in AVAILABLE_COLOURS.keys():
		modulate = AVAILABLE_COLOURS[colour]
		this_colour = colour 
	else:
		print_debug("Invalid colour: ", colour)
		
func get_colour():
	return this_colour
