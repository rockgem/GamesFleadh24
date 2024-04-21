extends Node2D


func _ready():
	ManagerGame.global_map_ref = self
	
	for enemy in get_tree().get_nodes_in_group('Enemy'):
		enemy.dead.connect(on_enemy_dead)


func get_closest_enemy():
	var enemies = get_tree().get_nodes_in_group('Enemy')
	
	if enemies.is_empty():
		return null
	
	var enemy = enemies[0]
	
	var distance: float = ManagerGame.global_player_ref.global_position.distance_to(enemies[0].global_position)
	
	
	for e in enemies:
		if e.is_dead:
			continue
		
		var d = ManagerGame.global_player_ref.global_position.distance_to(e.global_position)
		
		if d < distance:
			distance = d
			enemy = e
	
	if enemy.is_dead:
		enemy = null
	
	return enemy


func level_cleared():
	get_tree().get_nodes_in_group('Portal')[0].activate()


func on_enemy_dead():
	var enemies = get_tree().get_nodes_in_group('Enemy')
	
	if enemies.is_empty() or enemies.size() <= 1:
		level_cleared()
