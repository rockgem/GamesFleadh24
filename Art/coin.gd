extends Area2D

func _physics_process(_delta):
	$AnimatedSprite2D.play("idle")


func _on_body_entered(body):
	if body.name == "Knight":
		var tween = create_tween()
		
		tween.tween_property(self, "position", position + Vector2(0, -30), 0.2)
		
		tween.tween_property(self, "modulate:a", 0.0, 0.1)
		Global.coins += 1
		print("Coins:", Global.coins)
		tween.tween_callback(self.queue_free)
		
		

