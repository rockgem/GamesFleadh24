extends Area2D



func _on_body_entered(body):
	if body.name == "Knight":
		get_tree().paused = true
		get_node("Shop/Anim").play("TransIn")
		print("yyy")
