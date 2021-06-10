extends Node2D

onready var level1 = preload("res://scenes/Level1.tscn")

func _ready():
	pass

func _input(event):
	pass

func start_game():
	var new_level = level1.instance()
	add_child(new_level)


func pause_game():
	get_tree().paused = true
