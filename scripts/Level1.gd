extends Node2D

export var num := 100
export var margin := 100
var screensize : Vector2

func _ready():
	screensize = get_viewport_rect().size
	randomize()
	for i in num:
		spawn_boid()


func spawn_boid():
	var boid : Area2D = preload("res://scenes/boid.tscn").instance()
	$boids.add_child(boid)
#	boid.modulate = Color(randf(), randf(), randf(), 1)
	boid.global_position = Vector2((rand_range(margin, screensize.x - margin)), (rand_range(margin, screensize.y - margin)))
	boid.target = $Area2D


func _on_Timer_timeout():
	var num_boids := $boids.get_child_count()
	if num_boids < num:
		print("too few boids")
		for i in num - num_boids:
			spawn_boid()
