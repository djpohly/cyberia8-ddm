local t = Def.ActorFrame{

	Def.ActorFrame{
		--lifecover
		Condition=not GAMESTATE:IsDemonstration();
		Def.Quad{
			InitCommand=cmd(x,SCREEN_CENTER_X+60;y,-207;zoomtowidth,SCREEN_WIDTH/2-80;diffuse,color("0,0,0,0.5"));
			OnCommand=cmd(horizalign,left;zoomtoheight,0;sleep,0.8;linear,0.2;zoomtoheight,12;);
		};
		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..GetGameFrame().."_LifeFrame/percentframe_cover"))..{
			InitCommand=cmd(horizalign,right;zoomx,-1;x,SCREEN_CENTER_X+54;y,-225;);
			OnCommand=cmd(diffusealpha,0;addx,30;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,-30;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		
		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/Rave_LifeFrame/level"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X+138;y,-225;);
			OnCommand=cmd(diffusealpha,0;addx,30;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,-30;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};
};

return t;