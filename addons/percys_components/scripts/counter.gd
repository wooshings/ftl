## Counter Component
##
## Used to keep track of values that need to be shared by multiple components. Emits a signal when a value is changed, emptied, or filled.
extends Component
class_name CounterComponent

@export var value: float :
	set(v):
		value = clampf(v, 0, max_value)
		if first_frame: return
		if value <= min_value:
			empty.emit()
		elif value >= max_value:
			full.emit()
		else:
			adjusted.emit()
	get:
		return value

@export var max_value: float
@export var min_value: float

var first_frame: bool = true

## Emitted when the value reaches min_value.
signal empty
## Emitted when the value reaches max_value.
signal full
## Emitted when the value is changed.
signal adjusted

func _ready() -> void:
	await get_tree().get_frame()
	first_frame = false

## Add to the counter's value.
## Does the same as `value += x`
func add(num: float):
	self.value += num 

## Subtract from the counter's value.
## Does the same thing as `value -= x`
func sub(num: float):
	self.value -= num
