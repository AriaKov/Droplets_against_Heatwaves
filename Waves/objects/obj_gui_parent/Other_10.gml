///@desc ANCHOR
//Update the UI element's position
//tuto : https://www.youtube.com/watch?v=RbBgE3cUShc

//GUI SIZE
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

//VIEW GUIDE SIZE
var _vw = sprite_get_width(spr_gui_guide);
var _vh = sprite_get_height(spr_gui_guide);

//CENTER POSITION FOR GUIDE
var _vcx = _vw/2;
var _vcy = _vh/2;

//Starting location
var _x = xstart;
var _y = ystart;

//IDENTIFY ALL OFFSETS FOR VARIOUS ANCHORS	 
var _posx = [_x,	_gw/2 - (_vcx - _x),	 _gw - (_vw - _x)];		//(LEFT / CENTER / RIGHT)
var _posy = [_y,	_gh/2 - (_vcy - _y),	 _gh - (_vh - _y)];		//(TOP / MIDDLE / BOTTOM)



//APPLY OFFSETS BASED ON CURRENT ANCHOR
switch(anchor)
{
	//TOP
	case ANCHOR.TOP_LEFT:
		x = _posx[ALIGNMENTX.LEFT];
		y = _posy[ALIGNMENTY.TOP];	
		break;
	case ANCHOR.TOP_CENTER:
		x = _posx[ALIGNMENTX.CENTER];
		y = _posy[ALIGNMENTY.TOP];	
		break;
	case ANCHOR.TOP_RIGHT:
		x = _posx[ALIGNMENTX.RIGHT];
		y = _posy[ALIGNMENTY.TOP];	
		break;
	//MIDDLE
	case ANCHOR.MIDDLE_LEFT:
		x = _posx[ALIGNMENTX.LEFT];
		y = _posy[ALIGNMENTY.MIDDLE];	
		break;
	case ANCHOR.MIDDLE_CENTER:
		x = _posx[ALIGNMENTX.CENTER];
		y = _posy[ALIGNMENTY.MIDDLE];	
		break;
	case ANCHOR.MIDDLE_RIGHT:
		x = _posx[ALIGNMENTX.RIGHT];
		y = _posy[ALIGNMENTY.MIDDLE];	
		break;
	//BOTTOM
	case ANCHOR.BOTTOM_LEFT:
		x = _posx[ALIGNMENTX.LEFT];
		y = _posy[ALIGNMENTY.BOTTOM];	
		break;
	case ANCHOR.BOTTOM_CENTER:
		x = _posx[ALIGNMENTX.CENTER];
		y = _posy[ALIGNMENTY.BOTTOM];	
		break;
	case ANCHOR.BOTTOM_RIGHT:
		x = _posx[ALIGNMENTX.RIGHT];
		y = _posy[ALIGNMENTY.BOTTOM];	
		break;
}

active_pos = [x, y];

