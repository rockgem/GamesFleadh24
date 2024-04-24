extends Node2D

@export var towards = ''

func _ready():
	activate(false)


func _unhandled_input(event):
	if Input.is_action_just_pressed('interact'):
		if $Area2D.has_overlapping_bodies():
			ManagerGame.change_scene("res://Level/Level2.tscn")


func activate(b = true):
	if b:
		modulate.a = 0.0
		var t = create_tween()
		t.tween_property(self, 'modulate:a', 1.0, 2.0)
		
		$Area2D/CollisionShape2D.set('disabled', false)
		show()
	else:
		$Area2D/CollisionShape2D.set('disabled', true)
		hide()


func _on_area_2d_body_entered(body):
#	ManagerGame.change_scene("res://Level/Level2.tscn")
	$Label.show()


func _on_area_2d_body_exited(body):
	$Label.hide()
