extends Area2D

onready var rays = $rays.get_children()
var boids_in_vision := []
export var vel := Vector2.ZERO
const SPEED := 1
const MOVV := 48
var rotate = 0

var target
const TARGET_WEIGHT = 0.5
const SEPERATION_WEIGHT = 1.5
const COLLISION_AVOID_WEIGHT = 4

func _ready():
	randomize()


func set_target(target):
	self.target = target


func _physics_process(delta):
	boids()
	checkCollision()
	vel = vel.normalized() * SPEED
	move()
	rotate = lerp_angle(rotate, vel.angle_to_point(Vector2.ZERO), 0.4)


func boids():
	if target:
			var dist = (target.position - position)
			vel += dist * TARGET_WEIGHT  # TODO: have the weight falloff over distance
	
	if boids_in_vision:
		var num_boids := boids_in_vision.size()
		var avg_vel := Vector2.ZERO
		var avg_pos := Vector2.ZERO
		var steer_away := Vector2.ZERO
		for boid in boids_in_vision:
			avg_vel += boid.vel
			avg_pos += boid.position
			steer_away -= (boid.global_position - global_position) * (MOVV/(global_position - boid.global_position).length())
		
		avg_vel /= num_boids
#		vel += steer_towards(avg_vel)
		vel += (avg_vel - vel)/2
		
		avg_pos /= num_boids
#		vel += steer_towards(avg_pos)
		vel += (avg_pos - position)
		
		steer_away /= num_boids
#		vel += steer_towards(steer_away)
		vel += steer_away * SEPERATION_WEIGHT



func checkCollision():
#	for ray in rays:
#		var r : RayCast2D = ray
#		if not (r.is_colliding() and r.get_collider().is_in_group("blocks")):
#			vel += r.cast_to.normalized() * SPEED
	for ray in rays:
		var r : RayCast2D = ray
		if r.is_colliding():
			if r.get_collider().is_in_group("blocks"):
				var dist := 100/(r.get_collision_point() - global_position).length_squared()
				vel -= (r.cast_to.rotated(rotate) * dist) * COLLISION_AVOID_WEIGHT


func move():
	global_position += vel



func _on_vision_area_entered(area):
	if area != self and area.is_in_group("zombie"):
		boids_in_vision.append(area)


func _on_vision_area_exited(area):
	if area.is_in_group("zombie"):
		boids_in_vision.erase(area)


func _on_Boid_body_entered(body):
	if body and not body.is_in_group("player"):
		print("boid died")
		queue_free()
