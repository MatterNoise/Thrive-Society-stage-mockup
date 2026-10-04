extends ICreatureClass
class_name PersonCreature

var PersonResidentalCivilization : String

func _process(_Delta : float) -> void:
	velocity = Vector3.ZERO
	
	#look_at(TargetLocation)
	#velocity = -transform.basis.z * MovementSpeed
	
	move_and_slide()
