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
		_move(-1, 0)

	if (Input.is_action_just_pressed("ui_right")):
		_move(1, 0)

	if (Input.is_action_just_pressed("ui_up")):
		_move(0, -1)

	if (Input.is_action_just_pressed("ui_down")):
		_move(0, 1)

func _move(deltaX, deltaY):
	var currentPositionX = positionX
	var currentPositionY = positionY
	positionX = (currentPositionX + deltaX + MAP_SQUARE_SIZE) % MAP_SQUARE_SIZE
	positionY = (currentPositionY + deltaY + MAP_SQUARE_SIZE) % MAP_SQUARE_SIZE
	move_local_x((positionX - currentPositionX) * MOVEMENT_DISTANCE_PIXEL)
	move_local_y((positionY - currentPositionY) * MOVEMENT_DISTANCE_PIXEL)
	
	if (OS.is_debug_build()):
		print(_getMovementDescription(deltaX, deltaY))

func _getDirectionList(x, y):
	var directionList = []

	if (x > 0):
		directionList.push_back('right')

	if (x < 0):
		directionList.push_back('left')

	if (y > 0):
		directionList.push_back('down')

	if (y < 0):
		directionList.push_back('up')

	return directionList

func _getMovementDescription(x, y):
	var descriptionOfMoveDirection = PoolStringArray(
		_getDirectionList(x, y)
	).join(' and ')
	var descriptionFull = PoolStringArray([
		HERO_NAME,
		' moved ',
		descriptionOfMoveDirection,
		' to ',
		_currentPositionString()
	]).join('')
	return descriptionFull
