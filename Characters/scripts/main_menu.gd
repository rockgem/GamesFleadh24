class_name Main_Menu
extends Control


@onready var startbtn = $MarginContainer/HBoxContainer/VBoxContainer/Startbtn as Button
@onready var quitbtn = $MarginContainer/HBoxContainer/VBoxContainer/Quitbtn as Button
@onready var start_level = preload("res://Level/game_level.tscn") as PackedScene


func _ready():
	startbtn.button_down.connect(on_start_pressed)
	quitbtn.button_down.connect(on_exit_pressed)


func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()
