extends CharacterBody2D

const WALK_SPEED := 60.0
const RUN_SPEED := 150.0

@onready var screen_size = get_viewport_rect().size
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Tracks last direction faced
var facing_direction := "down"

func _physics_process(_delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	var is_running := Input.is_key_pressed(KEY_SHIFT)

	var current_speed := RUN_SPEED if is_running else WALK_SPEED

	if direction:
		velocity = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.y = move_toward(velocity.y, 0, current_speed)

	# ----- ANIMATION LOGIC -----

	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				facing_direction = "right"
				play_move_anim("right", is_running)
			else:
				facing_direction = "left"
				play_move_anim("left", is_running)
		else:
			if direction.y > 0:
				facing_direction = "down"
				play_move_anim("down", is_running)
			else:
				facing_direction = "up"
				play_move_anim("up", is_running)
	else:
		play_idle_anim()

	# ----- SCREEN CLAMP -----

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	move_and_slide()


func play_move_anim(dir: String, running: bool) -> void:
	var anim := "run_" + dir if running else "walk_" + dir
	if sprite.animation != anim:
		sprite.play(anim)


func play_idle_anim() -> void:
	var anim := "idle_" + facing_direction
	if sprite.animation != anim:
		sprite.play(anim)
