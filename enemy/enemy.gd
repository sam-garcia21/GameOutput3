extends Node2D

@export var health = 3

@onready var marker_2d: Marker2D = $Marker2D
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var fire_rate_timer: Timer = $FireRateTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate_timer.timeout.connect(fireOrbs)
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	
func fireOrbs() -> void:
	spawner_component.spawn(marker_2d.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
