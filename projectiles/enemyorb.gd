extends Node2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var explosion: AnimatedSprite2D = $ExplosionAnimation
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ensures orbs get deleted when off screen to save memory
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Player or area.owner.is_in_group("player_projectiles"):
		move_component.velocity = Vector2.ZERO
		animated_sprite_2d.visible = false
		explosion.visible = true
		explosion.play()
		await explosion.animation_finished
		queue_free()
