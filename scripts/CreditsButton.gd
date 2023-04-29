extends TextureButton


var time_out = 0
var button_pressed = false
onready var transition_overlay_sprite = $"../../TransitionOverlay/TransitionSprite"


func _process(delta):
	if button_pressed:
		if time_out < 1:
			time_out += (2 * delta)
			transition_overlay_sprite.modulate.a = time_out
		else:
			if (get_tree().change_scene("res://scenes/CreditsScene.tscn")) != OK:
				print("An unexpected error happened when trying to switch to the Credits scene.")


func _on_CreditsButton_pressed():
	button_pressed = true
