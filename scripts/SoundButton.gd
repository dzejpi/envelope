extends TextureButton


var sound_on = true
onready var sound_label = $"SoundLabel"


func _ready():
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Sound")):
		sound_on = false
		sound_label.text = "Sound: Off"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), true)
		self.pressed = false
		release_focus()
	else:
		sound_on = true
		sound_label.text = "Sound: On"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), false)
		self.pressed = true
		release_focus()


func _on_SoundButton_pressed():
	if sound_on:
		sound_on = false
		sound_label.text = "Sound: Off"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), true)
		self.pressed = false
		release_focus()
	else:
		sound_on = true
		sound_label.text = "Sound: On"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), false)
		self.pressed = true
		release_focus()
