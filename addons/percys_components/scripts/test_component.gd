extends Component
class_name TestComponent

func _ready() -> void:
	print(self.find_sibling_of_type(TestComponent))
