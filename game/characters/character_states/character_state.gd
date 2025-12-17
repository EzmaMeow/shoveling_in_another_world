#contains the bulk stats, infomation, and state of the character
class_name Character_State extends Resource

#states may be static in memory, but some cases a copy be more ideal
#since states may contain dynamic feilds like current hp and making a dedicated
#file for each enemy instance is not ideal for that case
#I was going to make it unique by default, but I feel they may be fix in memory most times
#having a ref to a static state is still recommened so that the base states can be update
#this type of state usally is used with saving
#NOTE: may not need to worry about a dynamic and static state. 
#saving may only save certain properties and these are the dynamic ones
#though it may be better to have componets of the state and then caculate stats
#base off that (like a race and class state) and have this always unique for non-named
#characters
@export var unique : bool = false
#default var are for basic movement cases
@export var speed : float = 80
