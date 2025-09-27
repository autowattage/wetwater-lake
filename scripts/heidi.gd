extends CharacterBody2D
const SPEED = 300.0
var JUMP_VELOCITY = -400.0
var inwater = false
var falls = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * .25 if inwater else get_gravity() * delta
	else:
		falls = false
		
	var direction := Input.get_axis("move_left", "move_right")
	if direction and not falls:
		velocity.x = direction * SPEED
		if inwater:
			$AnimatedSprite2D.play("swim")
		elif is_on_floor():
			$AnimatedSprite2D.play("run")
		$"water-detect/CollisionShape2D".shape = load("res://collisions/heidi-run.tres")
		$"water-detect/CollisionShape2D".rotation_degrees = 90
		$"water-detect/CollisionShape2D".position.x = -21*direction
		$CollisionShape2D.shape = load("res://collisions/heidi-run.tres")
		$CollisionShape2D.rotation_degrees = 90
		$AnimatedSprite2D.flip_h = direction<0
		$CollisionShape2D.position.x = -21*direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
		$"water-detect/CollisionShape2D".shape = load("res://collisions/heidi.tres")
		$"water-detect/CollisionShape2D".position.x = 0
		$"water-detect/CollisionShape2D".rotation_degrees = 0
		$CollisionShape2D.shape = load("res://collisions/heidi.tres")
		$CollisionShape2D.position.x = 0
		$CollisionShape2D.rotation_degrees = 0
	if Input.is_action_just_pressed("move_down") and not falls:
		falls = true
		velocity += get_gravity() * delta * 40
		$AnimatedSprite2D.play("fall")
		$"water-detect/CollisionShape2D".shape = load("res://collisions/heidi-fall.tres")
		$"water-detect/CollisionShape2D".position.x = 0
		$"water-detect/CollisionShape2D".rotation_degrees = 0
		$CollisionShape2D.shape = load("res://collisions/heidi-fall.tres")
		$CollisionShape2D.position.x = 0
		$CollisionShape2D.rotation_degrees = 0
	if Input.is_action_just_pressed("move_up"):
		if inwater or (not inwater and is_on_floor()):
			velocity.y = JUMP_VELOCITY
			if not inwater:
				$AnimatedSprite2D.play("jump")
			falls = false
	move_and_slide()
	

func _on_waterdetect_entered_water() -> void:
	inwater = true
	JUMP_VELOCITY = -200
func _on_waterdetect_exited_water() -> void:
	inwater = false
	JUMP_VELOCITY = -400
	velocity -= Vector2(0,250)
