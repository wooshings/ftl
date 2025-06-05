## Base Component class.
##
## All component types are extended from this class.
## Components will automatically find their root parent, skipping parents that are a Node or Component.
## This means that components can be children of other components, while still finding the root parent node.

extends Node
class_name Component

## The root parent of the component, skipping parents that are of type Node or Component.
var entity: Variant = null

func _enter_tree() -> void:
	var last_parent = self.get_parent()
	while entity == null:
		if last_parent is not Node or Component:
			entity = last_parent
			print("Discovered parent")
		else:
			last_parent = last_parent.get_parent()

## Searches the root parent for nodes that match the class type. Used to avoid creating hard coded references to nodes.
func find_sibling_of_type(type: Variant) -> Variant:
	for i in get_parent().get_children():
		if i is Variant and not i == self:
			return i
	print("Sibling of type could not be found..")
	return null

