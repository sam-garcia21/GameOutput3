extends Node2D

@onready var player: Node = $player
@onready var hp_bar: Label = $HP
@onready var game_over_screen: Control = $Game_Over

func _process(delta: float) -> void:
	if (player.health == 0):
		game_over_screen.visible = true
		hp_bar.visible = false
	else:
		hp_bar.text = "HP: " + str(player.health)
