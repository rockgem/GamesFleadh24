extends CharacterBody2D

var move_speed = 100.0

func _physics_process(delta):
	velocity.x = Input.get_axis('left', 'right') * move_speed
	velocity.y = Input.get_axis('up', 'down') * move_speed
	
	velocity.normalized()
	
	move_and_slide()
