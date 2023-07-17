extends Area2D

signal hit_wall

var speed = 400
var is_playing = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_playing:
		position.x -= delta * speed
		
	if position.x < -50:
		self.queue_free()

func _on_body_entered(body):
	print('dfsad')
	if body.is_in_group("Player"):
		SignalBus.emit_signal("hit_wall")
		
