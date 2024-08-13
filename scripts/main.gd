extends Node2D

@export var ai : bool

var turn := "RED" # Whose turn it is
var columns := [] # Array of all columns
var in_play := true # If the game is still being played
var ai_play : int # Last play the AI made

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for child in $'Columns'.get_children():
		child.column_clicked.connect(_on_column_clicked)
		columns.append(child)
		
func game_over():
	in_play = false
		
func compare_circles(circles : Array):
	for circle in circles:
		if circle.get_colour() != turn:
			return false
	return true

func check_columns():
	for i in 6:
		for j in 3:
			if compare_circles([columns[i].get_circle(j), columns[i].get_circle(j+1), columns[i].get_circle(j+2), columns[i].get_circle(j+3)]):
				print("column")
				game_over()

func check_rows():
	for i in 3:
		for j in 6:
			if compare_circles([columns[i].get_circle(j), columns[i+1].get_circle(j), columns[i+2].get_circle(j), columns[i+3].get_circle(j)]):
				print("row")
				game_over()
				
func check_diagonals():
	for i in 3:
		for j in 3:
			if compare_circles([columns[i].get_circle(j), columns[i+1].get_circle(j+1), columns[i+2].get_circle(j+2), columns[i+3].get_circle(j+3)]):
				print("diagonal")
				game_over()
	for i in 3:
		for j in range(3,6):
			if compare_circles([columns[i].get_circle(j), columns[i+1].get_circle(j-1), columns[i+2].get_circle(j-2), columns[i+3].get_circle(j-3)]):
				print("diagonal")
				game_over()

func check_for_four():
	check_columns()
	check_rows()
	check_diagonals()

func _on_column_clicked(column : Object):
	if in_play:
		if column.place_circle(turn):
			check_for_four()
			switch_turn()
			if ai && turn == "BLUE": make_ai_play()
			return true
		return false
	return true
	
func switch_turn():
	if turn == "RED": turn = "BLUE"
	else: turn = "RED"
	
func make_ai_play():
	if !ai_play: ai_play = randi_range(0,5)
	if randf() < 0.5: ai_play -= 1
	else: ai_play += 1
	ai_play = clamp(ai_play, 0, 5)
	if !_on_column_clicked(columns[ai_play]): make_ai_play()
