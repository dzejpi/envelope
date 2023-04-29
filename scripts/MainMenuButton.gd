extends TextureButton


func _on_MainMenuButton_pressed():
	if get_tree().change_scene("res://scenes/MainMenuScene.tscn") != OK:
		print("An unexpected error happened when trying to switch to the Main menu scene.")
