extends CharacterBody2D

@onready var animation_tree = $AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")


@export var move_speed : float = 75

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Left button was clicked at ", event.position)

#trying to make the attack here but it's still quite random 
func _process(delta): 
	if Input.is_mouse_button_pressed(1) : 
		$AnimationPlayer.play("attack_right") 

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	)

	# Normalize the vector to prevent faster diagonal movement
	input_direction = input_direction.normalized()
	
	velocity = input_direction * move_speed
	
	# Use the velocity in move_and_slide
	move_and_slide()
	

	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false 

	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true

	pick_new_state()
	
func update_animation_parameters (move_input : Vector2): 
	if(move_input != Vector2.ZERO): 
		animation_tree.set ("parameters/Walk/blend_position",move_input)
		animation_tree.set ("parameters/Idle/blend_position",move_input)


func pick_new_state() : 
	if (velocity!=Vector2.ZERO) : 
		state_machine.travel("Walk")
	if Input.is_action_pressed("mouse_left") :  
		state_machine.travel ("attack_right")
	elif (velocity==Vector2.ZERO):
		state_machine.travel("Idle")

