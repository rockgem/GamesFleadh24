extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 10
var player_alive = true

var attack_ip = false #attack in progress

@onready var animation_tree = $AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")


@export var move_speed : float = 75

func _physics_process(_delta):
	enemy_attack()
	update_health()
	
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

func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	if Input.is_action_pressed("mouse_left"):
		# Ensure that the attack animation continues until it finishes
		state_machine.travel("attack_right")
		Global.player_current_attack = true
		attack_ip = true
		$deal_attack_timer.start()
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
		health = health - 1
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false

func update_health():
	var healthbar = $HealthBar
	healthbar.value = health
	
	if health >= 10:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regentimer_timeout():
	if health < 10:
		health = health + 2
		if health > 10:
			health = 10
	if health <= 0:
		health = 0

func player_shop_method():
	pass
