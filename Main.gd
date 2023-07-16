extends Node2D

@export var obs_scene: PackedScene
var time_since_last_spawn = 0
var obs_instantiated = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass


func _on_timer_timeout():
	var rngNumber = rng.randf_range(1, 3)
	$Timer.wait_time = rngNumber	
	var obs = obs_scene.instantiate()
	if int(rngNumber) % 2 == 0:
		obs.scale *= 20
	else:
		obs.scale.x = 20
		obs.scale.y = 40
	obs.position = Vector2(1300, 460)
	add_child(obs)
	obs_instantiated += 1 # Replace with function body.
