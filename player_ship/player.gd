extends Node2D

class_name Player

signal damage_taken

@export var health = 20

# Only access once this scene is ready.
@onready var left_muzzle: Marker2D = $LeftMuzzle
@onready var right_muzzle: Marker2D = $RightMuzzle
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $Anchor/AnimatedSprite2D
@onready var flame_animated_sprite_2d: AnimatedSprite2D = $Anchor/FlameAnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var explosion: AnimatedSprite2D = $Anchor/ExplosionAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate_timer.timeout.connect(fireLasers)
	pass # Replace with function body.
	
func reset() -> void:
	health = 20
	flame_animated_sprite_2d.visible = true
	animated_sprite_2d.visible = true

func fireLasers() -> void:
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)
	scale_component.tween_scale()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		fire_rate_timer.emit_signal("timeout")
		fire_rate_timer.start()
	if Input.is_action_just_released("ui_select"):
		fire_rate_timer.stop()
	animate_the_ship()

func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
		flame_animated_sprite_2d.play("bank_left")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
		flame_animated_sprite_2d.play("bank_right")
	else:
		animated_sprite_2d.play("center")
		flame_animated_sprite_2d.play("center")
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("enemy_projectiles") or area.owner.is_in_group("enemies"):
		take_damage()
	pass # Replace with function body.
	
func take_damage() -> void:
	health -= 1
	damage_taken.emit()
	if health <= 0:
		flame_animated_sprite_2d.visible = false
		animated_sprite_2d.visible = false
		explosion.visible = true
		explosion.play()
		await explosion.animation_finished
		explosion.visible = false
	else :
		var tween = get_tree().create_tween()
		area_2d.set_deferred("monitoring", false)
		tween.tween_property(animated_sprite_2d, "modulate", Color(10, 10, 10), 0.9).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
		tween.tween_property(animated_sprite_2d, "modulate", Color(1, 1, 1), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		scale_component.tween_scale()
		await tween.finished
		area_2d.set_deferred("monitoring", true)
	
