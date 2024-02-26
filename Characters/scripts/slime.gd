extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

var health = 100
var player_in_attack_zone = false

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("idle")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	


func _on_detecting_area_body_entered(body):
	player = body
	player_chase = true


func _on_detecting_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_slime_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true


func _on_slime_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false

func deal_with_damage():
	if player_in_attack_zone and Global.player_current_attack == true:
		health = health - 20
		print("Slime health =", health)
		if health <= 0:
			self.queue_free()
