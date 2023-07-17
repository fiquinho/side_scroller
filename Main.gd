extends Node2D


const MIN_OBSTACLE_TIME = 1
const MAX_OBSTACLE_TIME = 3
const MEAN_OBSTACLE_TIME = (MAX_OBSTACLE_TIME + MIN_OBSTACLE_TIME) / 2
const OBSTACLE_SCALE_NORMAL = 20
const OBSTACLE_SCALE_BIG = 40
const START_POSITION_X = 1300
const START_POSITION_Y = 460

@export var obstacle_scene: PackedScene

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var obstacles_timer: Timer


func _generate_random_time() -> float:
	return rng.randf_range(MIN_OBSTACLE_TIME, MAX_OBSTACLE_TIME)
	
func _create_obstacle(random_time: float) -> Area2D:
	var obstacle = obstacle_scene.instantiate()
	var is_big = rng.randi_range(0, 1)
	if is_big:
		obstacle.scale.x = OBSTACLE_SCALE_NORMAL
		obstacle.scale.y = OBSTACLE_SCALE_BIG
	else:
		obstacle.scale *= OBSTACLE_SCALE_NORMAL
	obstacle.position = Vector2(START_POSITION_X, START_POSITION_Y)
	return obstacle

func _spawn_obstacle(random_time: float) -> void:
	var obstacle = _create_obstacle(random_time)
	add_child(obstacle)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var random_time = _generate_random_time()
	_spawn_obstacle(random_time)
	$Timer.start(random_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_obstacle_timer_timeout():
	
	# Random next obstacle spawn time
	var random_time = _generate_random_time()
	$Timer.wait_time = random_time
	
	_spawn_obstacle(random_time)
