extends Node2D


func _ready():
#	$Label.modulate.a = 0.0
	
	var duration = .3
	
	var t = create_tween().set_parallel()
#	t.tween_property($Label, 'modulate:a', 1.0, .3)
	t.tween_property(self, 'position:y', -32, .5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
#	t.tween_property($Label, 'modulate:a', 0.0, .3).set_delay(.3)
	
	await t.finished
	
	queue_free()
