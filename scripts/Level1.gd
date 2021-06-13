extends Node2D

export var num := 25
export var margin := 100
var screensize : Vector2

func _ready():
	screensize = get_viewport_rect().size
	randomize()
	for i in num:
		spawn_zombie()
	for i in num:
		spawn_human()


func spawn_zombie():
	var zombie : KinematicBody2D = preload("res://scenes/Zombie.tscn").instance()
	$zombies.add_child(zombie)
#	boid.modulate = Color(randf(), randf(), randf(), 1)
	zombie.global_position = Vector2((rand_range(margin, screensize.x - margin)), (rand_range(margin, screensize.y - margin))) # TODO: define area for spawning
	zombie.target = $Player


func spawn_soldier():
	var human : Area2D = preload("res://scenes/Soldier.tscn").instance()
	$humans.add_child(human)
	human.global_position = Vector2((rand_range(margin, screensize.x - margin)), (rand_range(margin, screensize.y - margin))) # TODO: define area for spawning


func spawn_human():
	var human : KinematicBody2D = preload("res://scenes/Human.tscn").instance()
	$humans.add_child(human)
	human.global_position = Vector2((rand_range(margin, screensize.x - margin)), (rand_range(margin, screensize.y - margin))) # TODO: define area for spawning


func _on_Timer_timeout():
	return
	var num_zombies := $zombies.get_child_count()
	if num_zombies < num:
		print("too few boids")
		for i in num - num_zombies:
			spawn_zombie()
