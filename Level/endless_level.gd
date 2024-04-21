extends Node2D


@onready var enemy = preload("res://actors/entities/Enemy.tscn")

var wave = 0


func _ready():
	ManagerGame.global_map_ref = self
	
	$CanvasLayer/UI/Control/HP.value = ManagerGame.global_player_ref.hurtbox.hp
	$CanvasLayer/UI/Control/HP.max_value = ManagerGame.global_player_ref.hurtbox.hp
	
	wave_start()


func _physics_process(delta):
	$CanvasLayer/UI/Time.text = '%ss' % int($WaveTimer.time_left)
	
	$CanvasLayer/UI/Control/HP.value = ManagerGame.global_player_ref.hurtbox.hp
	$CanvasLayer/UI/Control/EXP.value = ManagerGame.global_player_ref.exp
	$CanvasLayer/UI/Control/EXP.max_value = ManagerGame.global_player_ref.exp_max


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


func spawn_enemy(amount = 1):
	for i in range(amount):
		var e = enemy.instantiate()
		e.global_position = get_random_spawn_point()
		e.is_chaser_enemy = true
		
		add_child(e)


func get_random_spawn_point():
	var rand_x = randf_range($TL.global_position.x, $BR.global_position.x)
	var rand_y = randf_range($TL.global_position.y, $BR.global_position.y)
	
	return Vector2(rand_x, rand_y)


func wave_start():
	wave += 1
	
	$WaveTimer.start()
	$CanvasLayer/UI/Wave.text = 'Wave %s' % wave


func _on_spawn_timer_timeout():
	spawn_enemy()


func _on_wave_timer_timeout():
	wave_start()
