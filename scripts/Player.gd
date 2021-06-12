extends KinematicBody2D

const SPEED = 100

var velocity := Vector2.ZERO

func _ready():
	pass

func get_input():
    velocity = Vector2.ZERO
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    # Make sure diagonal movement isn't faster

    velocity = velocity.normalized() * SPEED

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)
