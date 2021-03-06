/obj/item
	name = "default item"
	desc = "not very interesting"
	var/range = 1 // usage range
	var/stackSize = 1 // The amount of objects held with it
	var/showAsLoot = FALSE // Whether the object is shown with a loot_icon
	var/loot_icon = 'sprite/obj/items.dmi' //icon of the item ont he floor
	var/loot_icon_state = "loot" //state of the item on the floor
	var/list/stats = list() // Stats that the object imparts to the player
	// The slot the object occupies
	var/slot //eyes, head, chest, groin, l_hand, r_hand, l_foot, r_foot, l_arm, r_arm, l_leg, r_leg, l_shoulder, r_shoulder
	var/obj/item/lootForm // setting this makes the object be harvested as an alternate type

/obj/item/New()
	..()
	if(showAsLoot)
		icon = loot_icon
		icon_state = loot_icon_state

/obj/item/proc/recalculateStat(var/datum/stat/S)
	if(!S || !istype(S))
		return

	var/statmod = stats[S.statId]

	S.statModified += statmod