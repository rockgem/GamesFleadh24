class_name Main_Menu
extends Control


func _ready():
	get_tree().paused = false


func _on_endless_mode_pressed():
	ManagerGame.change_scene("res://Level/endless_level.tscn")


func _on_start_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
