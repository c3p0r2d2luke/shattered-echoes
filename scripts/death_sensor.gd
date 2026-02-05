extends Area2D

# Reference to the AnimatedSprite2D (child node)
@onready var shark_sprite = $AnimatedSprite2D
var triggered = false

func _ready():
	# Make the shark invisible initially
	shark_sprite.visible = false
	# Connect the signal
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	# Only trigger if it's the player and hasn't already triggered
	if body.name == "Player" and not triggered:
		triggered = true
		# Make the shark visible
		shark_sprite.visible = true
		# Play the "eat" animation
		shark_sprite.play("eat")

func _on_animation_finished():
	shark_sprite.visible = false
