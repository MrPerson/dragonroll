

//Can update this to better logic later on
///
// Returns a TRUE/FALSE whether the given atom is adjacent
///
/atom/proc/Adjacent(var/atom/A)
	if(get_dist(A,src) > 1)
		return 0
	return 1

///
// Returns the angle between start and end.
///
/proc/Get_Angle(atom/movable/start,atom/movable/end)//For beams.
	if(!start || !end) return 0
	var/dy
	var/dx
	dy=(32*end.y+end.pixel_y)-(32*start.y+start.pixel_y)
	dx=(32*end.x+end.pixel_x)-(32*start.x+start.pixel_x)
	if(!dy)
		return (dx>=0)?90:270
	.=arctan(dx/dy)
	if(dy<0)
		.+=180
	else if(dx<0)
		.+=360


//Gets a file if it exists, including custom/dynamic paths using string manipulation
/proc/getfile(var/filepath)
	. = 0
	if(fexists(filepath))
		. = file(filepath)
