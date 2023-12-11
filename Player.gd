extends Area2D

@export var speed = 500 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 3
	if Input.is_action_pressed("move_left"):
		velocity.x -= 3
	if Input.is_action_pressed("move_down"):
		velocity.y += 3
	if Input.is_action_pressed("move_up"):
		velocity.y -= 3

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	$AnimatedSprite2D.play()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
