extends Node2D

@export var health = 3

@onready var animated_sprite_2d: AnimatedSprite2D = $Anchor/AnimatedSprite2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var area_2d: Area2D = $Area2D
@onready var explosion: AnimatedSprite2D = $Anchor/ExplosionAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate_timer.timeout.connect(fireOrbs)
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	
func fireOrbs() -> void:
	spawner_component.spawn(marker_2d.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("player_projectiles") or area.owner is Player:
		take_damage()

func take_damage() -> void:
	health -= 1
	if health <= 0:
		fire_rate_timer.stop()
		animated_sprite_2d.visible = false
		explosion.visible = true
		explosion.play()
		await explosion.animation_finished
		explosion.visible = false
		queue_free()
	else :
		var tween = get_tree().create_tween()
		area_2d.set_deferred("monitoring", false)
		tween.tween_property(animated_sprite_2d, "modulate", Color(10, 10, 10), 0.3).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
		tween.tween_property(animated_sprite_2d, "modulate", Color(1, 1, 1), 0.01).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		await tween.finished
		area_2d.set_deferred("monitoring", true)
