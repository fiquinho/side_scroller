extends CanvasLayer


@export var player: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("lose_life", _on_lose_life)
	$Lives.text = "Lives: " + str(GameConfig.starting_lifes)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_lose_life(previous, new):
	$Lives.text = "Lives: " + str(new)
