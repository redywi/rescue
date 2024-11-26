extends CanvasLayer

@onready var lost_label := $PanelContainer/HBoxContainer/Label
@export var max_lost_animals := 10 
var lost_animals := 0           

func update_indicator():
	lost_label.text = str(lost_animals) + " / " + str(max_lost_animals)
	if lost_animals > max_lost_animals:
		emit_signal("game_lost")

func add_lost_animal():
	lost_animals += 1
	update_indicator()
