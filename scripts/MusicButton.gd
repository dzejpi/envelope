extends TextureButton


var music_on = true
onready var music_label = $"MusicLabel"


func _ready():
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")):
		music_on = false
		music_label.text = "Music: Off"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
		self.pressed = false
		release_focus()
	else:
		music_on = true
		music_label.text = "Music: On"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		self.pressed = true
		release_focus()


func _on_MusicButton_pressed():
	if music_on:
		music_on = false
		music_label.text = "Music: Off"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
		self.pressed = false
		release_focus()
	else:
		music_on = true
		music_label.text = "Music: On"
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		self.pressed = true
		release_focus()
