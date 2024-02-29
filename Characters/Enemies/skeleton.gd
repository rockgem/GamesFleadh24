extends CharacterBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var speed = 110
var player = null
var chase = false
var alive = true

func enemy():
	pass

func _physics_process(delta):
	if chase == true:
		move_and_slide()
		position += (player.position - position)/speed
		state_machine.travel("Walk")
		#Postions the npc towards the player
		if(player.position.y - position.y) <= 0 :
			$"Skeleton-sheet".flip_h = true
		else:
			$"Skeleton-sheet".flip_h = false
			 
	else:
		state_machine.travel("Idle")
		
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player = body
		chase = true	
