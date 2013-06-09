local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","_delay"),0.5);

	Def.Quad{
		InitCommand=cmd(FullScreen);
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("0,0,0,1");accelerate,0.05;diffusealpha,0);
	};

	Def.Quad{
		OnCommand=cmd(diffuse,color("1,1,0,0.4");vertalign,top;x,SCREEN_CENTER_X;y,SCREEN_TOP;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.5;decelerate,0.3;fadebottom,0.4;zoomtoheight,0;);
	};

	Def.Quad{
		OnCommand=cmd(diffuse,color("1,1,0,0.4");vertalign,bottom;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT*0.5;decelerate,0.3;fadetop,0.4;zoomtoheight,0;);
	};
	
	LoadActor( THEME:GetPathB("","back_effect/left_effect" ) )..{
		OnCommand=cmd(horizalign,left;zoomtoheight,SCREEN_HEIGHT;x,SCREEN_LEFT*0.1;y,SCREEN_CENTER_Y+100;zoom,1.5;accelerate,0.3;addy,-100;diffusealpha,0;);
	};
	
	Def.Quad{
		OnCommand=cmd(blend,'BlendMode_Add';diffuse,color("0,0,1,1");x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;accelerate,0.3;zoomtoheight,SCREEN_HEIGHT*0.6;diffusealpha,0;);
	};
	
	Def.Quad{
		OnCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.6,0.3,0,1");x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;accelerate,0.15;zoomtoheight,SCREEN_HEIGHT*0.4;diffusealpha,0;);
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","back_effect/ver8" ) )..{
		OnCommand=cmd(horizalign,left;x,SCREEN_WIDTH*0.11;y,SCREEN_CENTER_Y+14;zoomtowidth,SCREEN_WIDTH*0.35;diffuse,color("0,1,1,0.7");zoom,0.5;accelerate,0.3;zoom,3;diffusealpha,0;);
	};
	
	LoadActor( THEME:GetPathB("","back_effect/cs8" ) )..{
		OnCommand=cmd(horizalign,left;x,SCREEN_WIDTH*0.11;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH*0.35;diffuse,color("1,0.5,0,0.7");diffuseleftedge,color("1,1,0,0.7");zoom,0.75;accelerate,0.3;zoom,3;diffusealpha,0;);
	};
};

return t;