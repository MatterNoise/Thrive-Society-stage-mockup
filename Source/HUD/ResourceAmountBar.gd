extends HBoxContainer
class_name ResourceAmountBar

@export var ResourceTextureNode : TextureRect
@export var ResourceLabelNode : Label

@export var ResourceIcon : CompressedTexture2D
@export var ResourceName : String

func _ready() -> void:
	if ResourceTextureNode == null or ResourceLabelNode == null:
		return
	
	ResourceTextureNode.texture = ResourceIcon
	ResourceLabelNode.text = ResourceName
