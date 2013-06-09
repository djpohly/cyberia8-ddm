local t = Def.ActorFrame{};

if not GAMESTATE:IsDemonstration() then
	--percentcover
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+15;);

		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/Regular_LifeFrame/percentframe_cover"))..{
			OnCommand=cmd(horizalign,right;zoomx,-1;x,54;diffusealpha,0;addx,-30;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,30;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--lifeframe_player2
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_TOP+35;);
		OnCommand=cmd(addx,SCREEN_WIDTH*0.4;zoomx,0;zoomy,0.3;accelerate,0.6;addx,-SCREEN_WIDTH*0.4;zoomx,1;decelerate,0.1;zoomy,1;);
		
		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/Regular_LifeFrame/lifeframe_up_width"))..{
			OnCommand=cmd(zoomx,-1;zoomtowidth,SCREEN_WIDTH/2-183-137;horizalign,right;x,SCREEN_RIGHT-75;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/Regular_LifeFrame/lifeframe_up_left"))..{
			OnCommand=cmd(horizalign,left;zoomx,-1;x,SCREEN_RIGHT-2/2+1;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/Regular_LifeFrame/lifeframe_down_right"))..{
			OnCommand=cmd(horizalign,right;zoomx,-1;x,SCREEN_CENTER_X+41;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};
end;

return t;
