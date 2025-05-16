class_name State_Run extends State

@export var move_speed : float = 60.0
@export var run_speed : float = 100.0

@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"


## What happens when the player enter this State?
func Enter() -> void:
	player.update_animation("run")
	pass


## What happens when the player exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * run_speed
	
	if player.set_direction():
		player.update_animation("run")
	
	return null


## What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens with input events in this State?
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	
	
	return null
