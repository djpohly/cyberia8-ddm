local t = Def.ActorFrame{
	Def.SongMeterDisplay {
		Name="SongMeterDisplay";
		InitCommand=cmd(SetStreamWidth,SCREEN_WIDTH-348/2);
		Stream=Def.Actor{};
		Tip=Def.ActorFrame{
			LoadActor("_tip")..{
				InitCommand=cmd(glowshift;effectperiod,3;effectcolor1,color("0,0,0,0");effectcolor2,color("0,0.7,1,0.6"););
			};
		};
	};
};

return t;