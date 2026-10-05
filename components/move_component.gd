class_name MoveComponent
extends Node

# EXPORT allows us to edit the values in inspector.
@export var velocity: Vector2	# For moving the ship.
@export var actor: Node2D	# For the ship.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	actor.translate(velocity * delta)
