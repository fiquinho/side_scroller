extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const gravity_mult = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_mult
var lives = GameConfig.starting_lifes


func _ready():
	SignalBus.connect("hit_wall", _on_hit_wall)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_hit_wall():
	lives -= 1
	SignalBus.emit_signal("lose_life", lives + 1, lives)
	_damage_blink()

func _damage_blink():
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1, 1 ,1 ,0), 0.25)
	tween.tween_property($Sprite2D, "modulate", Color(1, 1 ,1 , 1), 0.25)
	tween.tween_property($Sprite2D, "modulate", Color(1, 1 ,1 ,0), 0.25)
	tween.tween_property($Sprite2D, "modulate", Color(1, 1 ,1 , 1), 0.25)
