return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-34;diffuse,color("0,0,0,0.5");diffusealpha,0;zoomtowidth,0;zoomtoheight,1;);
		OnCommand=cmd(sleep,0.2;decelerate,0.30;zoomtowidth,SCREEN_WIDTH;diffusealpha,1);
	};
	Def.Quad{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+76;diffuse,color("0,0,0,0.5");diffusealpha,0;zoomtowidth,0;zoomtoheight,1;);
		OnCommand=cmd(sleep,0.2;decelerate,0.30;zoomtowidth,SCREEN_WIDTH;diffusealpha,1);
	};
	LoadActor( THEME:GetPathB("","_ranking/mask") )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+2;zwrite,true;blend,'BlendMode_NoEffect';vertalign,bottom;);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_TOP;valign,0;zoomto,SCREEN_WIDTH,78;zwrite,true;blend,'BlendMode_NoEffect';);
	};

	LoadActor( THEME:GetPathB("","_ranking/rankingtext") )..{
		InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_TOP+22;zoomy,0;decelerate,0.4;zoomy,1;);
	};
};