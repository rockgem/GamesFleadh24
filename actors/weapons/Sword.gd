extends Node2D


@onready var range = 50.0


func attack():
	var e = ManagerGame.global_map_ref.get_closest_enemy()
	
	if e:
		if global_position.distance_to(e.global_position) <= range:
			$AnimationPlayer.play("stab")
			
			var dif = global_position.direction_to(e.global_position)
			look_at(global_position + dif)
			
			e.take_damage(5)


func _on_attack_timer_timeout():
	attack()
