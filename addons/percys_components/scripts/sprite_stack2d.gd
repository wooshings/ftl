## Psuedo-3D sprite node.
##
## A node that displays a psuedo-3D texture. 
## Takes a single spritesheet texture where each slice of the model is one frame.
@tool
@icon("res://addons/percys_components/icons/sprite_stack_2d.png")
extends Node2D
class_name SpriteStack2D

## The sliced texture of the model.
@export var texture: Texture2D
## The number of slices in the model or texture.
@export var slices: int = 1
## If true, texture is centered.
@export var centered: bool
## The y offset in pixels between each slice.
@export var spacing: float = 1
## The rotation of the psuedo-3D model. Use this to render the model at different angles.
## [br][br]
## Note: Not the same as Node2D.rotation.
@export_range(0,360,0.1,"suffix:Degrees") var stack_rotation: float = 0 : 
	set(value):
		stack_rotation = fposmod(value, 360.0)
	get:
		return stack_rotation
@export var offset: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	for i in range(slices+1):
		var image_rect = Vector2(texture.get_width(), texture.get_height() / slices)
		var centered_position = position if not centered else position - (image_rect * 0.5)
		var slice_position = centered_position - Vector2(0, spacing * i)
		var region_rect = Rect2(Vector2(0, image_rect.y * (slices - i)), image_rect)
	
		var true_rotation = stack_rotation - rotation_degrees
		var origin_offset = image_rect * 0.5

		var camera2d = get_tree().get_root().get_viewport().get_camera_2d()
		var camera_rotation = camera2d.rotation_degrees if camera2d else 0
		draw_set_transform(slice_position + origin_offset + offset, deg_to_rad(true_rotation-camera_rotation), Vector2.ONE)
		draw_texture_rect_region(texture, Rect2(-origin_offset, image_rect), region_rect)

## Returns the height of the model as if it were a 3D object. 
## The same as using [code]SpriteStack2D.spacing * SpriteStack2D.slices[/code].
func get_height():
	return spacing * slices
