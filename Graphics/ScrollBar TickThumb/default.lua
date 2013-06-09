local t = Def.ActorFrame{

	LoadActor("TickThumb")..{
		OnCommand=cmd(zoomy,0;linear,0.3;zoomy,1;queuecommand,"Repeat";);
		RepeatCommand=cmd(blend,'BlendMode_Add';glowshift;effectperiod,3;effectcolor1,color("0,0,0,0");effectcolor2,color("1,0,0.7,0.6"););
		OffCommand=cmd(stoptweening;linear,0.3;zoomy,0;);
	};
};

return t;