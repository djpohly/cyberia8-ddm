PREFSMAN:SetPreference("AllowExtraStage",getenv("envAllowExtraStage"));

local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(FullScreen;);
		OnCommand=cmd(diffuse,color("0,0,0,0");linear,0.5;diffuse,color("0,0.5,0.5,1");linear,3;diffuse,color("0,0,0,0"););
	};

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+50;rotationz,-100;);
		OnCommand=cmd(zoom,0;decelerate,1;zoom,1.5;);
		LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
			InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.8,0.9,0,0.15");rotationx,60;sleep,1;linear,0.1;diffusealpha,0;);
			OnCommand=cmd(queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,0,0,6;);
		};
	};
	
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+50;);
		OnCommand=cmd(zoom,2.5;sleep,1.1;decelerate,0.5;zoom,0;rotationx,-90;rotationz,30;);
		LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
			InitCommand=cmd(diffuse,color("0.8,0.9,0,0.15");diffusealpha,0;sleep,1.1;linear,0.1;diffusealpha,0.15;);
			OnCommand=cmd(queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,0,0,6;);
		};
	};
	
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X+130;y,SCREEN_CENTER_Y+50;rotationx,0;rotationz,90;);
		OnCommand=cmd(zoom,0;decelerate,1;zoom,0.325*1.5;x,SCREEN_CENTER_X;decelerate,0.6;zoom,0;);
		Def.ActorFrame{
			OnCommand=cmd(queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,46,20,-38;);
			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.1");sleep,1;linear,0.5;diffusealpha,0;);
			};
			
			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.2");sleep,1;linear,0.5;diffusealpha,0;);
			};
		};
	};

	LoadActor( "gameover" )..{
		OnCommand=cmd(x,SCREEN_RIGHT-10;y,SCREEN_CENTER_Y+93;horizalign,right;vertalign,bottom;glow,color("0,0,0,0");cropleft,1;
					linear,0.5;cropleft,0;glow,color("1,1,0,0.8");linear,0.2;glow,color("0,0,0,0");sleep,1.4;linear,0.5;cropleft,1;diffusealpha,0;);
	};

	LoadActor( "thanks" )..{
		OnCommand=cmd(x,SCREEN_RIGHT-16;y,SCREEN_CENTER_Y+101;horizalign,right;glow,color("0,0,0,0");
					addx,-20;linear,1;addx,20;glow,color("1,0,0,1");linear,0.2;glow,color("0,0,0,0");sleep,0.9;linear,0.5;cropleft,1;diffusealpha,0;);
	};
};

return t;