local t = Def.ActorFrame{};

local coursemode = GAMESTATE:IsCourseMode();
local sjacketPath ,sbannerpath ,scdimagepath;
local showjacket = GetAdhocPref("ShowJackets");

if not coursemode then return t; end;

t[#t+1] = Def.ActorFrame{
	LoadActor("stagesongback_effect")..{
	};
	LoadActor("stageback_effect")..{
	};
};

t[#t+1] = LoadActor("banner")..{
};

if showjacket == "On" then
	t[#t+1] = LoadActor("jacket")..{
	};
	t[#t+1] = LoadActor("plus")..{
	};
end;

t[#t+1] = LoadActor("songtitle")..{
};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("1,1,1,1"););
		StartCommand=cmd(accelerate,0.5;diffuse,color("0,0,0,0"););
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	};
	
	Def.Quad{
		InitCommand=cmd(diffuse,color("1,1,0,0.4");vertalign,top;x,SCREEN_CENTER_X;y,SCREEN_TOP;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.5;);
		StartCommand=cmd(decelerate,0.4;fadebottom,0.4;zoomtoheight,0;);
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	};

	Def.Quad{
		InitCommand=cmd(diffuse,color("1,1,0,0.4");vertalign,bottom;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.5;);
		StartCommand=cmd(decelerate,0.4;fadetop,0.4;zoomtoheight,0;);
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	};
	
	Def.Quad{
		InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0,0,1,1");x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;);
		StartCommand=cmd(accelerate,0.4;zoomtoheight,SCREEN_HEIGHT*0.6;diffusealpha,0;);
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	};
	
	Def.Quad{
		InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.6,0.3,0,1");x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;);
		StartCommand=cmd(accelerate,0.25;zoomtoheight,SCREEN_HEIGHT*0.4;diffusealpha,0;);
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	};
};
return t;