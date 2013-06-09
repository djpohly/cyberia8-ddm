local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(vertalign,top;x,SCREEN_CENTER_X;y,SCREEN_TOP;zoomto,SCREEN_WIDTH,40;fadebottom,0.5;diffuse,color("0,1,1,0.3"));
	};
	
	Def.Quad{
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;zoomto,SCREEN_WIDTH,40;fadetop,0.5;diffuse,color("0,1,1,0.3"));
	};

	LoadActor("demoback1")..{
		InitCommand=cmd(horizalign,left;vertalign,top;x,SCREEN_LEFT-16;y,SCREEN_TOP+16;shadowlength,2;);
		OnCommand=cmd(addx,-370;sleep,0.4;decelerate,0.1;addx,370;);
	};
	
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_LEFT+200;y,SCREEN_TOP+34;);

		LoadActor("demoglow")..{
			OnCommand=cmd(zoomy,0;sleep,0.6;decelerate,0.1;zoomy,1;diffuseshift;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.75");effectperiod,2);
		};
		LoadActor("demonstration")..{
			OnCommand=cmd(zoomy,0;sleep,0.6;decelerate,0.1;zoomy,1);
		};
	};

	LoadActor(THEME:GetPathB("ScreenJukeBox","overlay"))..{
	};
};


return t;