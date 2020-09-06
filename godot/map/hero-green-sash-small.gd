extends Polygon2D


# Declare member variables here.
var HERO_NAME = 'Hero'
var MAP_SQUARE_SIZE = 3
var MAP_UNIT_SQUARE_SIZE_PIXEL = 64
var MAP_UNIT_SQUARE_BORDER_SIZE_PIXEL = 5

var MAP_HEIGHT = MAP_SQUARE_SIZE
var MAP_WIDTH = MAP_SQUARE_SIZE
var MOVEMENT_DISTANCE_PIXEL = (
	MAP_UNIT_SQUARE_SIZE_PIXEL
	+ MAP_UNIT_SQUARE_BORDER_SIZE_PIXEL
)

var positionX = 1
var positionY = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(_event):
	_handleInput()

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
	# Move the character units on the map.
	# Moving out of bounds wraps around the map.
	var currentPositionX = positionX
	var currentPositionY = positionY
	positionX = (currentPositionX + deltaX + MAP_WIDTH) % MAP_WIDTH
	positionY = (currentPositionY + deltaY + MAP_HEIGHT) % MAP_HEIGHT
	move_local_x((positionX - currentPositionX) * MOVEMENT_DISTANCE_PIXEL)
	move_local_y((positionY - currentPositionY) * MOVEMENT_DISTANCE_PIXEL)
	
	if (OS.is_debug_build()):
		print(_getMovementDescription(HERO_NAME, deltaX, deltaY))


# Logging methods here.
func _currentPositionString():
	# Get string for logging coordinates
	return '(' + String(positionX) + ', ' + String(positionY) + ')'

func _getOrthogonalDirection(deltaX, deltaY):
	# Get string for logging the orthogonal direction moved.
	if (deltaX > 0):
		return 'right'
	elif (deltaX < 0):
		return 'left'
	elif (deltaY > 0):
		return 'down'
	elif (deltaY < 0):
		return 'up'
	else:
		return ''

func _getMovementDescription(characterName, deltaX, deltaY):
	# Get string for logging where the character moved.
	return PoolStringArray([
		characterName,
		' moved ',
		_getOrthogonalDirection(deltaX, deltaY),
		' to ',
		_currentPositionString()
	]).join('')
