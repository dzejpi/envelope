extends Spatial


export var building_first_number = "100"
export var building_second_number = "101"
export var building_third_number = "102"
export var building_fourth_number = "103"

onready var building_number_label_first = $BuildingNumberLabelFirst
onready var building_number_label_second = $BuildingNumberLabelSecond
onready var building_number_label_third = $BuildingNumberLabelThird
onready var building_number_label_fourth = $BuildingNumberLabelFourth


var filled_boxes = 0

func _ready():
	building_number_label_first.text = building_first_number
	building_number_label_second.text = building_second_number
	building_number_label_third.text = building_third_number
	building_number_label_fourth.text = building_fourth_number


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
