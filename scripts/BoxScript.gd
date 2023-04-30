extends Spatial


export var row = 1

onready var full_box_sprite = $FullBoxSprite

var letter_sprite = preload("res://assets/visual/box_items/ase_box_items_letter.png")
var magazine_sprite = preload("res://assets/visual/box_items/ase_box_items_magazine.png")

var is_filled = false


func _ready():
	full_box_sprite.hide()
	full_box_sprite.texture = magazine_sprite
	
	randomize()
	var random_number = rand_range(0, 1)
	if random_number < 0.5:
		full_box_sprite.texture = magazine_sprite
	else:
		full_box_sprite.texture = letter_sprite
		
	var another_random_number = rand_range(0, 1)
	if another_random_number < 0.2:
		fill_box()


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
