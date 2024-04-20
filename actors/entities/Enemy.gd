extends Node2D


var move_speed = 80.0
var hp


func _physics_process(delta):
	var dif = global_position.direction_to(ManagerGame.global_player_ref.global_position)
	
	global_position += dif * move_speed * delta


func take_damage(damage = 1):
	$Hurtbox.take_damage(damage)
