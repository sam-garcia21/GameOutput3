extends Label

@onready var player: Node = $"../player"

func _process(delta: float) -> void:
	text = "HP: " + str(player.health)
