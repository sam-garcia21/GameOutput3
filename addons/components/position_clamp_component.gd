class_name PositionClampComponent
extends Node2D

# Export the actor whose position will be clamped
@export var actor: Node2D

# Export a margin for the boundaries
@export var margin: = 8

# Define horizontal borders
var left_border = 0
var right_border = ProjectSettings.get_setting("display/window/size/viewport_width")

# Define vertical borders using the viewport height
var top_border = 0
var bottom_border = ProjectSettings.get_setting("display/window/size/viewport_height")

func _process(delta: float) -> void:
	# Clamp the x position of the actor
	actor.global_position.x = clamp(actor.global_position.x, left_border + margin, right_border - margin)
	
	# Clamp the y position of the actor
	actor.global_position.y = clamp(actor.global_position.y, top_border + margin, bottom_border - margin)
