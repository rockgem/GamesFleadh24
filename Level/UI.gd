extends Control




func _on_retry_pressed():
	ManagerGame.change_scene("res://Level/endless_level.tscn")


func _on_main_menu_pressed():
	ManagerGame.change_scene("res://MainMenu/main_menu.tscn")
