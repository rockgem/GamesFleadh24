extends Control


func _unhandled_input(event):
	if Input.is_action_just_pressed('pause'):
		$PausePanel.show()
		get_tree().paused = true


func _on_resume_pressed():
	$PausePanel.hide()
	get_tree().paused = false


func _on_quit_pressed():
	ManagerGame.change_scene("res://MainMenu/main_menu.tscn")
