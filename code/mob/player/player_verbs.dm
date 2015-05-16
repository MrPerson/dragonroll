///
// DEBUG VERBS
///
/mob/player/verb/switchController()
	set name = "Toggle Controllers"
	set category = "Debug Verbs"
	var/datum/controller/c = input("Toggle What?") as null|anything in CS.controllers
	if(c)
		c.isRunning = !c.isRunning
		usr << "Selected controller toggled to [c.isRunning]"

/mob/player/verb/addAbility()
	set name = "Give Ability"
	set category = "Debug Verbs"
	var/d = input("Learn what?") as null|anything in typesof(/datum/ability)
	if(d)
		addPlayerAbility(new d)

/mob/player/verb/remAbility()
	set name = "Remove Ability"
	set category = "Debug Verbs"
	var/d = input("Forget what?") as null|anything in playerData.playerAbilities
	if(d)
		remPlayerAbility(d)


///
// INVENTORY AND STAT VERBS
///
/mob/player/verb/viewInventory()
	set name = "Open Inventory"
	var/html = "<title>Inventory</title><html><center>[parseIcon(src.client,src,FALSE)]<br><body style='background:grey'>"
	for(var/obj/item/I in playerInventory)
		html += "<b>[I.name]</b>: [I.stackSize] ([!isWorn(I) ? "<a href=?src=\ref[src];function=dropitem;item=\ref[I]><i>Drop</i></a>" : ""][isWearable(I) && !isWorn(I) ? " | <a href=?src=\ref[src];function=wearitem;item=\ref[I]><i>Equip</i></a>" : (isWorn(I) ? "<a href=?src=\ref[src];function=removeitem;item=\ref[I]><i>Remove</i></a>" : "")] | <a href=?src=\ref[src];function=useitem;item=\ref[I]><i>Use</i></a>)<br>"
	html += "</body></center></html>"
	src << browse(html,"window=playersheet")

/mob/player/verb/playerSheet()
	set name = "View Player Sheet"
	var/html = "<title>Player Sheet</title><html><center>[parseIcon(src.client,src,FALSE)]<br><body style='background:grey'>"
	html += "<b>Name</b>: [playerData.playerName][hasReroll ? " - <a href=?src=\ref[src];function=name><i>Change</i></a>" : ""]<br>"
	html += "<b>Gender</b>: [playerData.returnGender()][hasReroll ? " - <a href=?src=\ref[src];function=gender><i>Change</i></a>" : ""]<br>"
	html += "<b>Race</b>: <font color=[playerData.playerColor]>[playerData.playerRace.raceName]</font>[hasReroll ? " - <a href=?src=\ref[src];function=race><i>Change</i></a>" : ""]<br>"
	html += "<b>Class</b>: <font color=[playerData.playerClass.classColor]>[playerData.playerClass.className]</font>[hasReroll ? " - <a href=?src=\ref[src];function=class><i>Change</i></a>" : ""]<br>"
	html += "<b>Race Desc.</b>: [playerData.playerRace.raceDesc]<br>"
	html += "<b>Hairstyle</b>: [playerData.playerHair][hasReroll ? " - <a href=?src=\ref[src];function=sethair><i>Change</i></a>" : ""]<br>"
	html += "<b>Facial hair</b>: [playerData.playerFacial][hasReroll ? " - <a href=?src=\ref[src];function=setfacial><i>Change</i></a>" : ""]<br>"
	html += "<b>Eye Color</b>: <font color=[playerData.eyeColor]>Preview</font>[hasReroll ? " - <a href=?src=\ref[src];function=eyes><i>Change</i></a>" : ""]<br>"
	html += "<b>Hair Color</b>: <font color=[playerData.hairColor]>Preview</font>[hasReroll ? " - <a href=?src=\ref[src];function=haircolor><i>Change</i></a>" : ""]<br>"
	html += "<b>Description</b>: [playerData.playerDesc] - <a href=?src=\ref[src];function=desc><i>Add</i></a>/<a href=?src=\ref[src];function=descdelete><i>Remove</i></a><br><br>"
	for(var/datum/stat/S in playerData.playerStats)
		if(S.isLimited)
			html += "<b>[S.statName]</b>: [S.statModified]/[S.statMax]<br>"
		else
			html += "<b>[S.statName]</b>: [S.statModified]<br>"
	html += "[hasReroll ? "<a href=?src=\ref[src];function=statroll><b>Reroll Stats</b></a> <a href=?src=\ref[src];function=statkeep><b>Keep Stats</b></a>" : ""]<br>"
	html += "</body></center></html>"
	src << browse(html,"window=playersheet")

/mob/verb/forceRefreshInterface()
	set name = "Refresh Interface"
	set category = "Debug Verbs"
	for(var/o in screenObjs)
		usr << "Refreshing [o]"
	refreshInterface()


///
// INTERFACE SHORTCUTS
///
/mob/verb/KeyDown0()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[0]
	O.objFunction()

/mob/verb/KeyDown1()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[1]
	O.objFunction()

/mob/verb/KeyDown2()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[2]
	O.objFunction()

/mob/verb/KeyDown3()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[3]
	O.objFunction()

/mob/verb/KeyDown4()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[4]
	O.objFunction()

/mob/verb/KeyDown5()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[5]
	O.objFunction()

/mob/verb/KeyDown6()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[6]
	O.objFunction()

/mob/verb/KeyDown7()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[7]
	O.objFunction()

/mob/verb/KeyDown8()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[8]
	O.objFunction()

/mob/verb/KeyDown9()
	set hidden = TRUE
	var/obj/interface/O = screenObjs[9]
	O.objFunction()

/mob/verb/NextHotkey()
	set hidden = TRUE
	if(selectedHotKey + 1 <= maxHotkeys)
		++selectedHotKey
	else
		selectedHotKey = 1
	refreshInterface()

/mob/verb/NextHand()
	set hidden = TRUE
	if(selectedQuickSlot == leftPocket)
		selectedQuickSlot = leftHand
	else if(selectedQuickSlot == leftHand)
		selectedQuickSlot = rightHand
	else if(selectedQuickSlot == rightHand)
		selectedQuickSlot = rightPocket
	else if(selectedQuickSlot == rightPocket)
		selectedQuickSlot = leftPocket
	refreshInterface()

///
// ITEM HANDLING SHORTCUTS
//

/mob/verb/DropItem()
	if(selectedQuickSlot.contents.len > 0)
		var/obj/A = selectedQuickSlot.contents[1]
		A.loc = src.loc
	refreshInterface()

/mob/verb/UseHotkey()
	call(usr,"KeyDown[selectedHotKey]")(usr)

/mob/verb/LastHotkey()
	if(selectedHotKey - 1 >= 1)
		--selectedHotKey
	else
		selectedHotKey = 9
	refreshInterface()

/mob/player/verb/liftObj()
	set name = "Lift"
	set src = usr
	var/what = input("Pick up what?") as null|anything in filterList(/atom/movable/,oview(1))
	if(what)
		if(what:anchored)
			return
		var/atom/movable/a = what
		var/mob/player/m = src
		if(do_roll(1,20,m.playerData.str.statCur) >= a.weight + a.size)
			a.myOldLayer = a.layer
			a.myOldPixelY = a.pixel_y
			a.layer = LAYER_OVERLAY
			a.pixel_y = a.pixel_y + 10
			a.beingCarried = TRUE
			a.carriedBy = m
			m.carrying = a
			addProcessingObject(a)
		else
			displayTo("You can't quite seem to pick [a] up!",m,a)

/mob/player/verb/throwObj()
	set name = "Throw/Kick"
	set src = usr
	if(!carrying)
		var/list/excluded = list(src)
		excluded |= src.contents
		var/kickWhat = input("What do you want to kick?") as null|anything in filterList(/atom/movable/,view(1),excluded)
		if(kickWhat)
			if(kickWhat:anchored)
				return
			var/target = step(kickWhat,usr.dir)
			walk_to(kickWhat,target)
	else
		var/atom/movable/a = carrying
		var/mob/player/m = src
		if(do_roll(1,20,m.playerData.str.statCur) >= a.weight + a.size)
			var/t = input("Throw at what") as null|anything in filterList(/atom/movable,oview(max(m.playerData.str.statCur - (a.weight + a.size),1)))
			if(t)
				a.thrownTarget = t
				dropObj(m)
				a.thrown = TRUE
				addProcessingObject(a)

/mob/player/verb/dropObj()
	set name = "Drop"
	set src = usr
	if(carrying)
		displayInfo("You drop the [carrying]!","[src] drops the [carrying]!",src,carrying)
		carrying.beDropped()

///
// INTENT AND MOB CONTROL
///

/mob/verb/changeIntent()
	set name = "Change Intent"
	if(intent < 3)
		intent++
	else
		intent = 1
	displayTo("Your intent is now [intent2string()]",src,src)