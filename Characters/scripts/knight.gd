extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false #attack in progress

@onready var animation_tree = $AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")


@export var move_speed : float = 75

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$AnimationPlayer.play("attack_right")
			Global.player_current_attack = true

#trying to make the attack here but it's still quite random 
func _process(delta): 
	if Input.is_mouse_button_pressed(1) : 
		$AnimationPlayer.play("attack_right") 
		Global.player_current_attack = true

func _physics_process(_delta):
	enemy_attack()
	
	if health <= 0:
		player_alive = false  # add endscreen
		health = 0
		print("Player died")
		self.queue_free()

	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	)

	input_direction = input_direction.normalized()
	velocity = input_direction * move_speed
	move_and_slide()

	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true

	pick_new_state()

func update_animation_parameters(move_input: Vector2):
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	elif Global.player_current_attack:
		# Ensure that the attack animation continues until it finishes
		state_machine.travel("attack_right")
	else:
		state_machine.travel("Idle")

func player():
	pass

func _on_player_hit_box_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func _on_player_hit_box_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
