extends Node2D


onready var buttons = $Buttons

var is_countdown_started = false
var countdown = 5
var buttons_shown = false


# Called when the node enters the scene tree for the first time.
func _ready():
	buttons.hide()


func _process(delta):
	if is_countdown_started:
		if countdown > 0:
			countdown -= (1 * delta)
		else:
			if !buttons_shown:
				buttons_shown = true
				buttons.show()
