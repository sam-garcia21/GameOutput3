extends Node2D

const HP_BAR_SIZE_X = 95

@onready var player: Node = $player
@onready var enemy_generator: Node = $enemygenerator
@onready var enemy_generator2: Node = $enemygenerator2
@onready var hp: Control = $HP
@onready var hp_text: Label = $HP/Text
@onready var hp_bar: ColorRect = $HP/ColorRect
@onready var game_over_screen: Control = $Game_Over
@onready var music: AudioStreamPlayer = $Music

func _ready() -> void:
	hp_text.text = "HP: " + str(player.health)
	
func reset():
	player.reset()
	player.position = Vector2(80.0, 216.0)
	enemy_generator.start()
	enemy_generator2.start()
	game_over_screen.visible = false
	hp.visible = true
	hp_text.text = "HP: " + str(player.health)
	hp_bar.size.x = HP_BAR_SIZE_X
	music.play()

func _on_player_damage_taken() -> void:
	if (player.health == 0):
		game_over_screen.visible = true
		hp.visible = false
		enemy_generator.stop()
		enemy_generator2.stop()
		get_tree().call_group("enemies", "queue_free")
		get_tree().call_group("enemy_projectiles", "queue_free")
		get_tree().call_group("player_projectiles", "queue_free")
		music.stop()
	else:
		hp_text.text = "HP: " + str(player.health)
		hp_bar.size.x -= HP_BAR_SIZE_X * 1/float(20)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	reset()
