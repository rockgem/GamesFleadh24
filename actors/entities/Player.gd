extends CharacterBody2D

@onready var hurtbox = $Hurtbox

var exp = 0.0
var exp_max = 30.0

var move_speed = 100.0
var dash_speed = 140.0
var dash_duration = 0.3

var is_dashing = false
var direction = Vector2.ZERO

func _ready():
	ManagerGame.global_player_ref = self


func _unhandled_input(event):
	if Input.is_action_just_pressed("dash"):
		dash()


func _physics_process(delta):
	if is_dashing:
		velocity = direction * dash_speed * delta
		move_and_slide()
		
		return
	
	velocity.x = Input.get_axis('left', 'right') * move_speed
	velocity.y = Input.get_axis('up', 'down') * move_speed
	
	if velocity != Vector2.ZERO:
		direction = velocity
		
		if velocity.x < -0.5:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	
	velocity.normalized()
	
	move_and_slide()


func death():
	ManagerGame.game_over.emit()


func dash():
	is_dashing = true
	
	await get_tree().create_timer(dash_duration).timeout
	
	is_dashing = false


func _on_hurtbox_area_entered(area):
	# since i know that this area only detects enemy's area2d, i will then get the 
	# parent and delete the enemy scene right away.
	# this will make it so that when the enemy touches the player, the enemy gets deleted
	# and the player will take damage
	
	area.get_parent().queue_free()
	
	$HitAnim.play("hit")



func _on_hurtbox_hit():
	pass # Replace with function body.


func _on_hurtbox_zero():
	death()
