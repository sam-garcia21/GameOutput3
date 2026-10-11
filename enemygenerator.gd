extends Node2D

@export var EnemyScene: PackedScene
@export var min_y: int
@export var max_y: int
@export var min_wait: int
@export var max_wait: int

@onready var spawner_component: = $SpawnerComponent as SpawnerComponent
@onready var enemy_spawn_timer: Timer = $enemyspawntimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_spawn_timer.wait_time = randf_range(min_wait, max_wait)
	enemy_spawn_timer.start()
	enemy_spawn_timer.timeout.connect(handle_spawn.bind(EnemyScene, enemy_spawn_timer))

func handle_spawn(enemy_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(-10,randf_range(min_y,max_y)))
	timer.wait_time = randf_range(min_wait, max_wait)
	timer.start()

func start() -> void:
	enemy_spawn_timer.start()
	
func stop() -> void:
	enemy_spawn_timer.stop()
