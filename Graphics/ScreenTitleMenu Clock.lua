return LoadFont("Common normal")..{
	InitCommand=cmd(horizalign,right;diffuse,color("1,1,1,1");strokecolor,color("0,0,0,1");zoom,0.45;shadowlength,1;maxwidth,SCREEN_WIDTH;);
	BeginCommand=cmd(settext, string.format("%04i/%i/%i %i:%02i", Year(), MonthOfYear()+1,DayOfMonth(), Hour(), Minute());sleep,1;queuecommand,"Begin");
};