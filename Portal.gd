extends Area2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var entered = false
var complete = false

var enemy_count = 0

func _on_body_entered(body:PhysicsBody2D):
 
	print("Entered")
	entered = true

func _on_body_exited(body):
	print("Exit")
	entered = false

func _process(delta):
		state_machine.travel("Idle")
		if complete == true:
			state_machine.travel("Arriving")
			if entered == true:
				if Input.is_action_just_pressed("use"):
					print("Read input")
					get_tree().change_scene("res://Level/level_2.tscn")

func condition_met():
	complete = true
	print("Oh the condition thing works")
	

func update_enemy_count():
	# Here you can update a UI element or just print the count
	print("Number of enemies in area: ", enemy_count)



func _on_enemies_detection_body_entered(body):
	if body.has_method("enemy"):
		enemy_count = enemy_count +  1
		print(enemy_count)


func _on_enemies_detection_body_exited(body):
		enemy_count = enemy_count - 1
		
		if enemy_count == 0:
			condition_met()
