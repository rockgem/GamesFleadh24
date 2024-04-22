extends Control


func _ready():
	for display in $Panel/VBoxContainer/HFlowContainer.get_children():
		display.tapped.connect(on_slot_tapped)


func on_slot_tapped(own):
	if own.is_unlocked:
		ManagerGame.change_scene("res://Level/Level%s.tscn" % own.level_index)


func _on_level_selection_close_pressed():
	queue_free()
