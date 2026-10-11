extends Node2D

@export var EnemyScene: PackedScene

@onready var spawner_component: = $SpawnerComponent as SpawnerComponent
@onready var enemy_spawn_timer: Timer = $enemyspawntimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_spawn_timer.timeout.connect(handle_spawn.bind(EnemyScene, enemy_spawn_timer))

func handle_spawn(enemy_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(-10,randf_range(40,100)))
	timer.start()

func start() -> void:
	enemy_spawn_timer.start()
	
func stop() -> void:
	enemy_spawn_timer.stop()
