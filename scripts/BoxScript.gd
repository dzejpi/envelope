extends Spatial


export var row = 1

onready var full_box_sprite = $FullBoxSprite

var is_filled = false


func _ready():
	full_box_sprite.hide()


func fill_box():
	if !is_filled:
		is_filled = true
		full_box_sprite.show()
		
		match(row):
			1:
				get_parent().get_parent().get_parent().get_parent().filled_boxes_first_row += 1
				get_parent().get_parent().get_parent().get_parent().update_filled_boxes()
			2:
				get_parent().get_parent().get_parent().get_parent().filled_boxes_second_row += 1
				get_parent().get_parent().get_parent().get_parent().update_filled_boxes()
			3:
				get_parent().get_parent().get_parent().get_parent().filled_boxes_third_row += 1
				get_parent().get_parent().get_parent().get_parent().update_filled_boxes()
			4:
				get_parent().get_parent().get_parent().get_parent().filled_boxes_fourth_row += 1
				get_parent().get_parent().get_parent().get_parent().update_filled_boxes()
