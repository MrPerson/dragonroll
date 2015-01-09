/obj/effect
	name = "effect"
	desc = "generic effect"
	layer = LAYER_DEFAULT
	icon = 'sprite/obj/effects.dmi'
	var/length = 1 // how long it runs for
	var/procTime = 0 // internal, used to count down
	var/repeat = FALSE // repeat the animation?
	var/repeatTimes = 2 //how many times to repeat
	var/repeatCounter = 0 //counted repeats

/obj/effect/New()
	..()
	procTime = length
	addProcessingObject(src)

/obj/effect/doProcess()
	if(procTime <= 0)
		if(repeat && repeatCounter < repeatTimes)
			procTime = length
			++repeatCounter
		else
			del(src)
	else
		--procTime

//effects

/obj/effect/target
	name = "Targeted"
	desc = "There is a reticule targeting this location."
	length = 4.75
	repeat = TRUE
	icon_state = "effect_target"

/obj/effect/explode_single
	name = "Explosion"
	desc = "Warning: should not be looked at."
	length = 4.05
	repeat = FALSE
	icon_state = "effect_explode_single"

/obj/effect/explode_multiple
	name = "Explosion"
	desc = "Warning: should not be looked at."
	length = 4.05
	repeat = FALSE
	icon_state = "effect_explode_multiple"

/obj/effect/heal
	name = "Red Cross"
	desc = "May signify something healthy."
	length = 5
	repeat = FALSE
	icon_state = "effect_heal"

/obj/effect/poison
	name = "Toxic"
	desc = "Signifies something is marginally more toxic than the average garbage can."
	length = 3
	repeat = TRUE
	icon_state = "effect_poison"

/obj/effect/strike
	name = "Slash"
	desc = "Rending through space-time at the speed of 3.15 ticks."
	length = 3.15
	repeat = FALSE
	icon_state = "effect_strike"

/obj/effect/pow
	name = "Poof"
	desc = "Clouds of indetermined origin."
	length = 4.05
	repeat = FALSE
	icon_state = "effect_pow"