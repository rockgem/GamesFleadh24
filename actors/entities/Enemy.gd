extends Node2D

signal dead

@export var enemy_id = 'Demon'
@export var is_chaser_enemy = false
var is_dead = false

var move_speed = 80.0


func _ready():
	var data = ManagerGame.enemies_data[enemy_id]
	move_speed = data['move_speed']
	$Hurtbox.hp = data['hp']
	
	$Sprite2D.texture = load("res://reso/sprites/enemies/%s.tres" % enemy_id)


func _physics_process(delta):
	if is_chaser_enemy:
		var dif = global_position.direction_to(ManagerGame.global_player_ref.global_position)
		
		global_position += dif * move_speed * delta


func take_damage(damage = 1):
	$Hurtbox.take_damage(damage)
	
	$HitAnim.play("hit")


func death():
	is_dead = true
	set_physics_process(false)
	$AnimationPlayer.play('death')
	
	await $AnimationPlayer.animation_finished
	
	dead.emit()
	
	queue_free()


func _on_hurtbox_zero():
	death()
