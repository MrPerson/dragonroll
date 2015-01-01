/obj
	name = "default object"
	desc = "not very interesting"

/obj/DblClick()
	objFunction(usr)

/mob/player/verb/pickupItem(mob/user)
	set name = "Pick up"
	var/what = input("Pick up what?") as null|anything in filterList(/atom/movable/,view(1))
	if(what)
		var/atom/movable/a = what
		var/mob/player/m = user
		if(do_roll(1,20,m.playerData.str.statCur) >= a.weight + a.size)
			a.myOldLayer = layer
			a.layer = LAYER_OVERLAY
			a.pixel_y = a.pixel_y + 10
			a.beingCarried = TRUE
			a.carriedBy = m
			carrying = a
			addProcessingObject(a)
		else
			displayTo("You can't quite seem to pick [a] up!",m,a)

/mob/player/verb/throwItem(mob/user)
	set name = "Throw/Kick"
	if(!carrying)
		var/kickWhat = input("What do you want to kick?") as null|anything in filterList(/atom/movable/,view(1))
		if(kickWhat)
			var/target = step(kickWhat,usr.dir)
			walk_to(kickWhat,target)
	else
		var/atom/movable/a = carrying
		var/mob/player/m = user
		if(do_roll(1,20,m.playerData.str.statCur) >= a.weight + a.size)
			var/t = input("Throw at what") as null|anything in filterList(/atom/movable,oview(max(m.playerData.str.statCur - (a.weight + a.size),1)))
			if(t)
				a.thrownTarget = t
				dropItem(m)
				a.thrown = TRUE
				addProcessingObject(a)

/mob/player/verb/dropItem(mob/user)
	set name = "Drop"
	set src in view(1)
	if(carrying)
		carrying.beDropped()

//the function of an object when used, IE switching modes or reading books
/obj/proc/objFunction(var/mob/user)
	user << "You used the [name]"