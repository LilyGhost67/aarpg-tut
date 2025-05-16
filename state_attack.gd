class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed: float = 5.0

@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk: State = $"../Walk"
@onready var run: State_Run = $"../Run"

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var idle: State = $"../Idle"
@onready var hurt_box: HurtBox = %AttackHurtBox



## What happens when the player enter this State?
func Enter() -> void:
	player.update_animation("attack")
	animated_sprite_2d.animation_finished.connect( EndAttack )
	
	attacking = true
	
	await get_tree().create_timer (0.20).timeout
	hurt_box.monitoring = true
	
	#await get_tree().create_timer (0.075).timeout
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	pass


## What happens when the player exits this State?
func Exit() -> void:
	animated_sprite_2d.animation_finished.disconnect( EndAttack )
	attacking = false
	hurt_box.monitoring = false
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null


## What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens with input events in this State?
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed("run"):
		return run
	
	return null


func EndAttack() -> void:
	attacking = false
	#print ("Attack animation finished")
