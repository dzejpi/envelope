extends TextureButton


func _on_ContinueGameButton_pressed():
	get_parent().is_game_paused = false
