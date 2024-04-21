extends Node2D


func _ready():
	ManagerGame.global_map_ref = self


func get_closest_enemy():
	var enemies = get_tree().get_nodes_in_group('Enemy')
	
	if enemies.is_empty():
		return null
	
	var enemy = enemies[0]
	
	var distance: float = ManagerGame.global_player_ref.global_position.distance_to(enemies[0].global_position)
	
	
	for e in enemies:
		var d = ManagerGame.global_player_ref.global_position.distance_to(e.global_position)
		
		if d < distance:
			distance = d
			enemy = e
	
	return enemy
