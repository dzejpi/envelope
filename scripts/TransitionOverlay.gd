extends Node2D


var time_out = 0
onready var transition_overlay_sprite = $TransitionSprite


func _ready():
	transition_overlay_sprite.modulate.a = 1
	transition_overlay_sprite.scale.x = OS.window_size.x
	transition_overlay_sprite.scale.y = OS.window_size.y


func _process(delta):
	
	# Redraw if necessary
	transition_overlay_sprite.scale.x = OS.window_size.x
	transition_overlay_sprite.scale.y = OS.window_size.y

	if time_out < 1:
		time_out += (2 * delta)
		transition_overlay_sprite.modulate.a = 1 - time_out
