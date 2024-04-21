extends AnimatedSprite2D


var enemy = ''


# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = randi() % ManagerGame.global_map_ref.enemy_variants.size()
	var rand_enemy_id = ManagerGame.global_map_ref.enemy_variants[rand]
	
	await animation_finished
	
	var instance = ManagerGame.global_map_ref.enemy.instantiate()
	instance.get_node('Hurtbox').hp = ManagerGame.enemies_data[rand_enemy_id]['hp'] * ManagerGame.global_map_ref.hp_multiplier
#	instance.get_node('Sprite2D').texture = load("res://reso/data/enemy_sprites/%s.tres" % rand_enemy_id)
	instance.enemy_id = rand_enemy_id
	instance.is_chaser_enemy = true
	
	ManagerGame.global_map_ref.spawn_obj(instance, global_position)
	
	queue_free()

