extends Area2D

signal zero
signal hit

@export var hp = 5


func take_damage(damage = 1):
	hp -= damage
	
	var d = ManagerGame.df.instantiate()
	d.get_node('Label').text = '%s' % damage
	add_child(d)
	
	var fx = ManagerGame.hit_fx.instantiate()
	add_child(fx)
	
	hit.emit()
	
	if hp <= 0:
		zero.emit()


func _on_area_entered(area):
	take_damage()
