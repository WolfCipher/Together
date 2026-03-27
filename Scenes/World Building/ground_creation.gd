@tool # necessary for changes to be visible in the viewport, not just after press play
extends Node2D

# set(value) means on change from original value to new value, 'value'
# on these changes, we update the boundaries so that we can see the changes in the viewport and in the game

@export var leftBoundaryX := -4020.0:
	set(value):
		leftBoundaryX = value
		_update_boundaries()

@export var rightBoundaryX := 10867.0:
	set(value):
		rightBoundaryX = value
		_update_boundaries()

@export var topBoundaryY := -3222.0:
	set(value):
		topBoundaryY = value
		_update_boundaries()

@export var bottomBoundaryY := 9055.0:
	set(value):
		bottomBoundaryY = value
		_update_boundaries()

func _update_boundaries():
	if not is_inside_tree():
		return

	# checking for null is important --- game will break from accessing nil during runtime otherwise
	var left = get_node_or_null("LeftBoundary")
	var right = get_node_or_null("RightBoundary")
	var top = get_node_or_null("TopBoundary")
	var bottom = get_node_or_null("BottomBoundary")

	if left:
		left.position.x = leftBoundaryX
	if right:
		right.position.x = rightBoundaryX
	if top:
		top.position.y = topBoundaryY
	if bottom:
		bottom.position.y = bottomBoundaryY
