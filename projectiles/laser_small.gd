extends Node2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var explosion: AnimatedSprite2D = $ExplosionAnimation
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	 # Ensures lasers get deleted when off screen to save memory
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("enemy_projectiles") or area.owner.is_in_group("enemies"):
		move_component.velocity = Vector2.ZERO
		sprite.visible = false
		explosion.visible = true
		explosion.play()
		await explosion.animation_finished
		queue_free()
