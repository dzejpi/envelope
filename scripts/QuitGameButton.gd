extends TextureButton


var platform = OS.get_name()
var time_out = 0
var button_pressed = false
onready var transition_overlay_sprite = $"../../TransitionOverlay/TransitionSprite"


func _ready():
	# Disable if running in browser
	if platform == "HTML5":
		self.disabled = true


func _process(delta):
	if button_pressed:
		if time_out < 1:
			time_out += (2 * delta)
			transition_overlay_sprite.modulate.a = time_out
		else:
			release_focus()
			get_tree().quit()

func _on_QuitGameButton_pressed():
	button_pressed = true
