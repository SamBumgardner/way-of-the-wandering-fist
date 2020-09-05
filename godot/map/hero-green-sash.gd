extends Polygon2D


# Declare member variables here.
var MAP_SQUARE_SIZE = 3
var MAP_UNIT_SQUARE_SIZE_PIXEL = 64
var MAP_UNIT_SQUARE_BORDER_SIZE_PIXEL = 5

var MOVEMENT_DISTANCE_PIXEL = (
	MAP_UNIT_SQUARE_SIZE_PIXEL
	+ MAP_UNIT_SQUARE_BORDER_SIZE_PIXEL
)

var MAP_HEIGHT = MAP_SQUARE_SIZE
var MAP_WIDTH = MAP_SQUARE_SIZE

var HERO_NAME = 'Hero'
var MAXIMUM_POSITION_X = MAP_WIDTH - 1
var MAXIMUM_POSITION_Y = MAP_HEIGHT - 1
var MINIMUM_POSITION_X = 0
var MINIMUM_POSITION_Y = 0
var positionX = 1
var positionY = 1

var CONSOLE_OUTPUT = false
var IS_WRAP_AROUND = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(_event):
	_handleInput()

func _currentPositionString():
	return '(' + String(positionX) + ', ' + String(positionY) + ')'

func _handleInput():
	if (Input.is_action_just_pressed("ui_left")):
		_moveLeft()

	if (Input.is_action_just_pressed("ui_right")):
		_moveRight()

	if (Input.is_action_just_pressed("ui_up")):
		_moveUp()

	if (Input.is_action_just_pressed("ui_down")):
		_moveDown()

func _moveDown():
	var currentPositionY = positionY

	positionY = (positionY - 1 + MAP_HEIGHT) % MAP_HEIGHT
	move_local_y((currentPositionY - positionY) * MOVEMENT_DISTANCE_PIXEL)

	if (OS.is_debug_build()):
		print(HERO_NAME + ' moved down to ' + _currentPositionString())

func _moveLeft():
	var currentPositionX = positionX

	positionX = (positionX - 1 + MAP_WIDTH) % MAP_WIDTH
	move_local_x((currentPositionX - positionX) * -MOVEMENT_DISTANCE_PIXEL)

	if (OS.is_debug_build()):
		print(HERO_NAME + ' moved left to ' + _currentPositionString())

func _moveRight():
	var currentPositionX = positionX

	positionX = (positionX + 1) % MAP_WIDTH
	move_local_x((currentPositionX - positionX) * -MOVEMENT_DISTANCE_PIXEL)

	if (OS.is_debug_build()):
		print(HERO_NAME + ' moved right to ' + _currentPositionString())

func _moveUp():
	var currentPositionY = positionY

	positionY = (positionY + 1) % MAP_HEIGHT
	move_local_y((currentPositionY - positionY) * MOVEMENT_DISTANCE_PIXEL)

	if (OS.is_debug_build()):
		print(HERO_NAME + ' moved up to ' + _currentPositionString())
