extends Area2D


var speed = 400
var is_playing = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_playing:
		position.x -= delta * speed


func _on_body_entered(body):
	
	if body.is_in_group("Player"):
		is_playing = false
		
