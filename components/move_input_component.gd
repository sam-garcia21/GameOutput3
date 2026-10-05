class_name MoveInputComponent
extends Node

# Get input from user and set a velocity from said input.
@export var move_stat: MoveStat
@export var move_component: MoveComponent

func _input(event: InputEvent) -> void:
	# Get both horizontal and vertical axes
	var input_axis_x = Input.get_axis("ui_left", "ui_right")
	var input_axis_y = Input.get_axis("ui_up", "ui_down")
	
	# Combine into a Vector2 and scale by speed
	var input_vector = Vector2(input_axis_x, input_axis_y)
	
	# Optional: Normalize the vector so diagonal movement isn't faster
	input_vector = input_vector.normalized()
	
	move_component.velocity = input_vector * move_stat.speed
