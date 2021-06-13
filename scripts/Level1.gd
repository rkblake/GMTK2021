extends Node2D

var zombies
var humans

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
	$GUI/TextureRect/Humans.text = "HUMANS: %d" % $humans.get_child_count()
	$GUI/TextureRect/Zombies.text = "ZOMBIES: %d" % $zombies.get_child_count()


func spawn_zombie(pos = Vector2.ZERO):
	var zombie : Area2D = preload("res://scenes/Zombie.tscn").instance()
	$zombies.add_child(zombie)
#	boid.modulate = Color(randf(), randf(), randf(), 1)
	if pos == Vector2.ZERO:
		zombie.global_position = Vector2((rand_range(margin, screensize.x - margin)), (rand_range(margin, screensize.y - margin))) # TODO: define area for spawning
	else:
		zombie.global_position = pos
	zombie.target = $Player


func spawn_soldier():
	var human : Area2D = preload("res://scenes/Soldier.tscn").instance()
	$humans.add_child(human)
	human.global_position = Vector2((rand_range(margin, screensize.x - margin)), (rand_range(margin, screensize.y - margin))) # TODO: define area for spawning


func spawn_human():
	var human : Area2D = preload("res://scenes/Human.tscn").instance()
	$humans.add_child(human)
	human.global_position = Vector2((rand_range(margin, screensize.x - margin)), (rand_range(margin, screensize.y - margin))) # TODO: define area for spawning
	human.connect("human_died", self, "_on_Human_human_died")


func _on_Timer_timeout():
	return
	var num_zombies := $zombies.get_child_count()
	if num_zombies < num:
		print("too few boids")
		for i in num - num_zombies:
			spawn_zombie()


func _on_Human_human_died(pos):
	spawn_zombie(pos)
	$GUI/TextureRect/Humans.text = "HUMANS: %d" % $humans.get_child_count()
	$GUI/TextureRect/Zombies.text = "ZOMBIES: %d" % $zombies.get_child_count()
