extends CharacterBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var speed = 110
var player = null
var chase = false
var health = 120
var can_take_damage = true

var player_in_attack_zone = false
func enemy():
	pass

func _physics_process(delta):
	update_health()
	deal_with_damage()
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
		
func _on_skele_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true


func _on_skele_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false  

func deal_with_damage():
	if player_in_attack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 1
			$take_damage_cooldown.start()
			can_take_damage = false
			print("Skele health =", health)
			if health <= 0:
				self.queue_free()


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player = body
		chase = true 

func _on_hitbox_area_entered(body):
		player_in_attack_zone = true

func _on_hitbox_area_exited(body):
		player_in_attack_zone = false

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func update_health():
	var healthbar = $SkeleBar
	
	healthbar.value = health
	
	if health >= 120:
		healthbar.visible = false
	else:
		healthbar.visible = true
