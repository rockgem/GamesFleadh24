extends Panel

signal tapped


@export var level_index = 1.0

var is_unlocked = false

func _ready():
	$Label.text = 'Level %s' % level_index
	
	if ManagerGame.player_data['levels_completed'].has(level_index):
		$TextureRect.show()
		$Lock.hide()
		
		is_unlocked = true
	else:
		$Lock.show()
		$TextureRect.hide()


func _on_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		tapped.emit(self)
