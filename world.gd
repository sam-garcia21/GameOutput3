extends Node2D

@onready var player: Node = $player
@onready var enemy_generator: Node = $enemygenerator
@onready var hp_bar: Label = $HP
@onready var game_over_screen: Control = $Game_Over

func _ready() -> void:
	hp_bar.text = "HP: " + str(player.health)
	
func reset():
	player.reset()
	player.position = Vector2(80.0, 216.0)
	enemy_generator.start()
	game_over_screen.visible = false
	hp_bar.visible = true
	hp_bar.text = "HP: " + str(player.health)

func _on_player_damage_taken() -> void:
	if (player.health == 0):
		game_over_screen.visible = true
		hp_bar.visible = false
		enemy_generator.stop()
		get_tree().call_group("enemies", "queue_free")
		get_tree().call_group("enemy_projectiles", "queue_free")
		get_tree().call_group("player_projectiles", "queue_free")
		
	else:
		hp_bar.text = "HP: " + str(player.health)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	reset()
