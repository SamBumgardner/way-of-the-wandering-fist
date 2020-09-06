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
		#_moveLeft()
		_moveDelta(-1, 0)

	if (Input.is_action_just_pressed("ui_right")):
		# _moveRight()
		_moveDelta(1, 0)

	if (Input.is_action_just_pressed("ui_up")):
		# _moveUp()
		_moveDelta(0, 1)

	if (Input.is_action_just_pressed("ui_down")):
		# _moveDown()
		_moveDelta(0, -1)

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

func _moveDelta(x, y):
	# _moveDelta(1, 1) means to move diagonally North East.
	var currentPositionX = x
	var currentPositionY = y

	positionX = (positionX + MAP_WIDTH + x) % MAP_WIDTH
	positionY = (positionY + MAP_HEIGHT + y) % MAP_HEIGHT

	var calculatedDeltaX = currentPositionX - positionX + MAP_WIDTH
	var calculatedDeltaXPixel = calculatedDeltaX * MOVEMENT_DISTANCE_PIXEL

	#var calculatedDeltaY = currentPositionY - positionY
	var calculatedDeltaY = positionY - currentPositionY
	var calculatedDeltaYPixel = calculatedDeltaY * MOVEMENT_DISTANCE_PIXEL
	print(PoolStringArray([
		'MDeltaY', y, positionY, calculatedDeltaY, calculatedDeltaYPixel
	]))

	if (x != 0):
		move_local_x(calculatedDeltaXPixel)

	if (y != 0):
		move_local_y(calculatedDeltaYPixel)

	if (OS.is_debug_build()):
		print(getMovementDescription(x, y))

func getDirectionList(x, y):
	var directionList = []

	if (x > 0):
		directionList.push_back('right')

	if (x < 0):
		directionList.push_back('left')

	if (y > 0):
		directionList.push_back('up')

	if (y < 0):
		directionList.push_back('down')

	return directionList

func getMovementDescription(x, y):
	var descriptionOfMoveDirection = PoolStringArray(
		getDirectionList(x, y)
	).join(' and ')
	var descriptionFull = (
		HERO_NAME
		+ ' moved '
		+ descriptionOfMoveDirection
		+ ' to '
		+ _currentPositionString()
	)
	return descriptionFull
	
