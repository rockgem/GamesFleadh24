extends Area2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var entered = false
var complete = true

func _on_body_entered(body:PhysicsBody2D):
	print("Entered")
	entered = true

func _on_body_exited(body):
	print("Exit")
	entered = false

func _process(delta):
		state_machine.travel("Idle")
		if complete == true:
			if entered == true:
				if Input.is_action_just_pressed("use"):
					print("I READ THE FUCKING INPUT DIPSHIT")
					#get_tree().change_scene("res://Level/game_level.tscn")

func condition_met():
	var complete = true
	print("Oh the condition thing works")
	state_machine.travel("Arriving")
