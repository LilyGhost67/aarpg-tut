class_name State_Walk extends State

@export var move_speed : float = 60.0

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"
@onready var run: State = $"../Run"


## What happens when the player enter this State?
func Enter() -> void:
	player.update_animation("walk")
	pass


## What happens when the player exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	
	return null


## What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens with input events in this State?
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	
	if _event.is_action_pressed("run"):
		return run
	
	return null
