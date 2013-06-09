--[[_StepsDisplayListRow cursor p1]]

local t = Def.ActorFrame {
	LoadActor("p1_1")..{
		InitCommand=cmd(x,-7.5;y,-15+3;blend,'BlendMode_Add';diffuseshift;effectcolor1,color("0,0.2,0.5,1");effectcolor2,color("0,0.5,1,1");effectperiod,2.5;);
	};

	LoadActor("p1_2")..{
		InitCommand=cmd(x,-7.5;y,-15+3;diffusealpha,0;linear,1;diffusealpha,0.65;glowshift;effectcolor1,color("0.8,0.2,0.6,0.5");effectcolor2,color("1,1,1,0");effectperiod,2.5;);
	};

	LoadActor("p1_3")..{
		InitCommand=cmd(x,-22.5;y,1+3;diffusealpha,0;linear,1;diffusealpha,1;diffuseshift;effectcolor1,color("0,0,0,0");effectcolor2,color("1,0.7,0.3,1");effectperiod,2;);
	};

	LoadActor("p1_4")..{
		InitCommand=cmd(x,-22.5;y,1+3;diffusealpha,0;linear,1;diffusealpha,1;);
	};
};

return t