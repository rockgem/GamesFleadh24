extends Node


@onready var df = preload("res://actors/objs/DamageFloater.tscn")


signal fader_step_finished
signal fader_finished

var global_player_ref = null
var global_map_ref = null


func fade():
	var material = $CanvasLayer/Control/Fader.get('material')
	var duration = .8
	var t = create_tween()
	t.step_finished.connect(on_step_finished)
	t.finished.connect(on_finished)
	
	t.tween_property(material, 'shader_parameter/progress', 1.0, duration)
	t.tween_property(material, 'shader_parameter/progress', 0.0, duration)


func on_step_finished(idx):
	fader_step_finished.emit(idx)


func on_finished():
	fader_finished.emit()


# this function is responsible for changing maps or scenes while also at the same time doing the transition animation
func change_scene(path):
	var material = $CanvasLayer/Control/Fader.get('material')
	var duration = .8
	var t = create_tween()
	t.tween_property(material, 'shader_parameter/progress', 1.0, duration)
	t.tween_property(material, 'shader_parameter/progress', 0.0, duration)
	
	await t.step_finished
	get_tree().change_scene_to_file(path)
