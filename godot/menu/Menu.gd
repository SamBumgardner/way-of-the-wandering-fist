extends Node2D

signal menuDirectionSelected(direction)

# Directional constants, used for index lookup in _menuOptions
enum Direction {UP, LEFT, RIGHT, DOWN, NONE = -1}
# List of nodes that represent different menu options. Populated at runtime.
var _menuOptions = [0, 1, 2, 3]
# Boolean for whether menu inputs should be accepted or not.
var _acceptingInput = true

# Hold preloaded texture for swapping option graphics when selected.
var _optionHighlightTexture
var _optionNormalTexture

func _ready():
	_optionHighlightTexture = preload("res://menu/OptionHighlight.png")
	_optionNormalTexture = preload("res://menu/OptionNormal.png")
	_menuOptions[Direction.UP] = $OptionUp
	_menuOptions[Direction.LEFT] = $OptionLeft
	_menuOptions[Direction.RIGHT] = $OptionRight
	_menuOptions[Direction.DOWN] = $OptionDown

func _getInputDirection():
	var direction = Direction.NONE
	if Input.is_action_just_pressed("ui_up"):
		direction = Direction.UP
	if Input.is_action_just_pressed("ui_left"):
		direction = Direction.LEFT
	if Input.is_action_just_pressed("ui_right"):
		direction = Direction.RIGHT
	if Input.is_action_just_pressed("ui_down"):
		direction = Direction.DOWN
	
	return direction

# Should be called by parent when the menu should be "reset" with new options.
func updateOptions(newOptionTexts):
	for i in _menuOptions.size():
		_menuOptions[i].get_node("Label").text = newOptionTexts[i]
	resetOptions()

func resetOptions():
	for option in _menuOptions:
		option.get_node("Arrow").texture = _optionNormalTexture
		_acceptingInput = true

func _process(_delta):
	# temp code for testing
	if OS.is_debug_build() and Input.is_action_just_pressed("ui_accept"):
		var randomText = str(randi())
		updateOptions(["up " + randomText, "left " + randomText, 
			"right " + randomText, "down " + randomText])
	
	var direction = _getInputDirection();
	if _acceptingInput && direction != Direction.NONE:
		if OS.is_debug_build():
			print("Menu direction pressed: ", direction)
		
		_menuOptions[direction].get_node("Arrow").texture = _optionHighlightTexture
		emit_signal("menuDirectionSelected", direction)
		_acceptingInput = false