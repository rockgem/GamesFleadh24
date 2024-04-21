extends Node2D


@onready var range = 50.0
@export var damage = 4


func attack():
	if ManagerGame.global_map_ref == null:
		return
	
	var e = ManagerGame.global_map_ref.get_closest_enemy()
	
	if e:
		if global_position.distance_to(e.global_position) <= range:
			$AnimationPlayer.play("stab")
			
			var dif = global_position.direction_to(e.global_position)
			look_at(global_position + dif)
			
			e.take_damage(damage)


func _on_attack_timer_timeout():
	attack()
