extends Spatial

export var building_number = "10"
export var building_first_number = "100"
export var building_second_number = "101"
export var building_third_number = "102"
export var building_fourth_number = "103"

onready var building_number_label = $BuildingNumber/BuildingNumberLabel
onready var building_number_label_2 = $BuildingNumber/BuildingNumberLabel2

onready var building_number_label_first = $BuildingNumberLabelFirst
onready var building_number_label_second = $BuildingNumberLabelSecond
onready var building_number_label_third = $BuildingNumberLabelThird
onready var building_number_label_fourth = $BuildingNumberLabelFourth

var filled_boxes_first_row = 0
var filled_boxes_second_row = 0
var filled_boxes_third_row = 0
var filled_boxes_fourth_row = 0

var is_first_row_full = false
var is_second_row_full = false
var is_third_row_full = false
var is_fourth_row_full = false


func _ready():
	building_number_label.text = building_number
	building_number_label_2.text = building_number
	building_number_label_first.text = building_first_number
	building_number_label_second.text = building_second_number
	building_number_label_third.text = building_third_number
	building_number_label_fourth.text = building_fourth_number

func update_filled_boxes():
	if filled_boxes_first_row == 10:
		is_first_row_full = true
		
	if filled_boxes_second_row == 10:
		is_second_row_full = true
		
	if filled_boxes_third_row == 10:
		is_third_row_full = true
		
	if filled_boxes_fourth_row == 10:
		is_fourth_row_full = true
