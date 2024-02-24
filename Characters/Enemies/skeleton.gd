extends Node2D
var speed = 25
var player = null
var chase = false
func _physics_process(delta):
	if chase == true:
		position += (player.position - position)/speed
	

func _on_area_2d_body_entered(body:PhysicsBody2D):
	player = body
	chase = true
