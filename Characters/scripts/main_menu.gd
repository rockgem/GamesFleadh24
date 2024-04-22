class_name Main_Menu
extends Control


func _ready():
	get_tree().paused = false


func on_level_select():
	pass


func pop_to_ui(instance):
	for child in $Popups.get_children():
		child.queue_free()
	
	$Popups.add_child(instance)


func _on_endless_mode_pressed():
	ManagerGame.change_scene("res://Level/endless_level.tscn")


func _on_start_pressed():
	var i = load("res://actors/ui/popups/LevelSelection.tscn").instantiate()
	pop_to_ui(i)


func _on_quit_pressed():
	get_tree().quit()
