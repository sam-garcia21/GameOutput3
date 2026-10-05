extends Node2D

# Only access once this scene is ready.
@onready var left_muzzle: Marker2D = $LeftMuzzle
@onready var right_muzzle: Marker2D = $RightMuzzle
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $Anchor/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate_timer.timeout.connect(fireLasers)
	pass # Replace with function body.

func fireLasers() -> void:
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)
	scale_component.tween_scale()

func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
	else:
		animated_sprite_2d.play("center")
	pass
