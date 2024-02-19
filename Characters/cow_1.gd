extends CharacterBody2D

enum COW_STATE {IDLE, WALK} 

@export var move_speed : float = 30 

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var move_direction : Vector2=Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE 

func _ready () : 
	select_new_direction ()
	
	
func _physics_process(_delta):
	velocity = move_direction*move_speed 
	
	move_and_slide()
	
func select_new_direction(): 
	move_direction = Vector2 (
		randi_range(-1, 1),
		randi_range(-1 ,1)
	)
func pick_new_state() : 
	if (current_state == COW_STATE.IDLE) : 
		state_machine.travel("Walk")
		current_state = COW_STATE.WALK
	
	elif (current_state ==COW_STATE.WALK) : 
		state_machine.travel("Idle") 
		current_state = COW_STATE.IDLE
