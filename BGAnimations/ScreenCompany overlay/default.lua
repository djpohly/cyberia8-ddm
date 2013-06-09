InitPrefCSTitle()

local t = Def.ActorFrame{};
	
t[#t+1] = Def.Quad{
	InitCommand=cmd(FullScreen;draworder,-100;diffuse,color("0,0.2,0.2,1"););
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100;x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+50;);
	Def.ActorFrame{
		InitCommand=cmd(zoom,0.4;rotationx,-120;rotationz,-90;);
		OnCommand=cmd(queuecommand,"Repeat";);
		RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.1"););
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.2"););
		};
	};

	Def.ActorFrame{
		InitCommand=cmd(zoom,1.5;rotationx,0;rotationz,40;rotationy,30;);

		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.5");queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,-5,-4,2;);
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=cmd(zoom,0.8;blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.6");queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,3,-4,-2;);
		};
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor("warning")..{
		InitCommand=cmd(x,SCREEN_RIGHT-270-10;y,SCREEN_CENTER_Y;zoom,1;shadowlength,3;);
		OnCommand=cmd(diffusealpha,0;linear,0.2;diffusealpha,1;sleep,6.7;linear,0.05;zoomtoheight,2;sleep,0.05;linear,0.05;zoomtowidth,2100;linear,0.2;diffusealpha,0;);
	};

	Def.Quad{
		InitCommand=cmd(x,SCREEN_RIGHT-128-20;y,SCREEN_CENTER_Y-60;zoomto,256,96;shadowlength,3;);
		OnCommand=cmd(diffusealpha,0;sleep,7.1;linear,0.2;diffusealpha,1;sleep,4.8;linear,0.05;zoomtoheight,2;sleep,0.05;linear,0.05;zoomtowidth,2100;linear,0.2;diffusealpha,0;);
	};		
	LoadActor("../../../_fallback/BGAnimations/ScreenInit background/ssc")..{
		InitCommand=cmd(x,SCREEN_RIGHT-128-20;y,SCREEN_CENTER_Y-60;zoom,1;);
		OnCommand=cmd(diffusealpha,0;sleep,7.1;linear,0.2;diffusealpha,1;sleep,4.8;linear,0.05;zoomtoheight,2;sleep,0.05;linear,0.05;zoomtowidth,2100;linear,0.2;diffusealpha,0;);
	};
	LoadActor("stepmania")..{
		InitCommand=cmd(x,SCREEN_RIGHT-245-10;y,SCREEN_CENTER_Y+60;zoom,1;shadowlength,3;);
		OnCommand=cmd(diffusealpha,0;sleep,7.1;linear,0.2;diffusealpha,1;sleep,4.8;linear,0.05;zoomtoheight,2;sleep,0.05;linear,0.05;zoomtowidth,2100;linear,0.2;diffusealpha,0;);
	};

	LoadActor("cstylepro")..{
		InitCommand=cmd(x,SCREEN_RIGHT-230-10;y,SCREEN_CENTER_Y-50;zoom,1;shadowlength,3;);
		OnCommand=cmd(diffusealpha,0;sleep,12.2;linear,0.2;diffusealpha,1;sleep,4.8;linear,0.05;zoomtoheight,2;sleep,0.05;linear,0.05;zoomtowidth,2100;linear,0.2;diffusealpha,0;);
	};
	LoadActor("cc")..{
		InitCommand=cmd(x,SCREEN_RIGHT-285-10;y,SCREEN_CENTER_Y+50;zoom,1;shadowlength,3;);
		OnCommand=cmd(diffusealpha,0;sleep,12.2;linear,0.2;diffusealpha,1;sleep,4.8;linear,0.05;zoomtoheight,2;sleep,0.05;linear,0.05;zoomtowidth,2100;linear,0.2;diffusealpha,0;);
	};
};

return t;
