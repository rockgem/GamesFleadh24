extends Node2D



func _ready():
	activate(false)


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
	pass # Replace with function body.
