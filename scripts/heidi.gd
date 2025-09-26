extends CharacterBody2D
const SPEED = 300.0
var JUMP_VELOCITY = -400.0
var inwater = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * .25 if inwater else get_gravity() * delta

	if Input.is_action_just_pressed("move_down"):
		velocity += get_gravity() * delta * 40
	if Input.is_action_just_pressed("move_up"):
		if inwater or (not inwater and is_on_floor()):
			velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = direction<0
		$AnimatedSprite2D.speed_scale = 0.5 if inwater else 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
	move_and_slide()

func _on_waterdetect_entered_water() -> void:
	inwater = true
	JUMP_VELOCITY = -200
func _on_waterdetect_exited_water() -> void:
	inwater = false
	JUMP_VELOCITY = -400
	velocity -= Vector2(0,250)
