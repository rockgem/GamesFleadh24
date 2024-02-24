extends CharacterBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var speed = 10
var player = null
var chase = false



func _physics_process(delta):
	if chase == true:
		position += (player.position - position)/speed
		

func _on_area_2d_body_entered(body:PhysicsBody2D):
	player = body
	chase = true
	#state_machine.travel("Walk")
