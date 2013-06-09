--[[ScreenGameplay ScoreFrame]]
local t = Def.ActorFrame{};

local setxp1 = SCREEN_CENTER_X - 52;
local setxp2 = SCREEN_CENTER_X + 52;
if GetScreenAspectRatio() >= 2.66666666666666 then
	setxp1 = setxp1 + 0.5;
	setxp2 = setxp2 + 0.5;
end;
	
if not GAMESTATE:IsDemonstration() then
	--scoreframe_player1
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_BOTTOM-30;);
		OnCommand=cmd(addx,SCREEN_WIDTH*0.4;zoomx,0;zoomy,0.3;decelerate,0.4;addx,-SCREEN_WIDTH*0.4;zoomx,1;accelerate,0.125;zoomy,1;);
	
		LoadActor(""..GetGameFrame().."_ScoreFrame/scoreframe_width")..{
			OnCommand=cmd(y,2;zoomx,1;zoomtowidth,SCREEN_WIDTH/2-257-59;horizalign,left;x,SCREEN_LEFT+188;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(""..GetGameFrame().."_ScoreFrame/scoreframe_left")..{
			OnCommand=cmd(horizalign,left;zoomx,1;x,SCREEN_LEFT/2;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(""..GetGameFrame().."_ScoreFrame/scoreframe_right")..{
			OnCommand=cmd(y,-2;horizalign,right;zoomx,1;x,setxp1;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--scoreframe_player2
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_BOTTOM-30;);
		OnCommand=cmd(addx,SCREEN_WIDTH*0.6;zoomx,0;zoomy,0.3;decelerate,0.4;addx,-SCREEN_WIDTH*0.6;zoomx,1;accelerate,0.125;zoomy,1;);
	
		LoadActor(""..GetGameFrame().."_ScoreFrame/scoreframe_width")..{
			OnCommand=cmd(y,2;zoomx,-1;zoomtowidth,SCREEN_WIDTH/2-257-59;horizalign,right;x,SCREEN_RIGHT-188;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(""..GetGameFrame().."_ScoreFrame/scoreframe_left")..{
			OnCommand=cmd(horizalign,left;zoomx,-1;x,SCREEN_RIGHT+2/2-1;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
		LoadActor(""..GetGameFrame().."_ScoreFrame/scoreframe_right")..{
			OnCommand=cmd(y,-2;horizalign,right;zoomx,-1;x,setxp2;sleep,0.5;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};
	
	--bpmframe_player1
	t[#t+1] = LoadActor(""..GetGameFrame().."_ScoreFrame/bpmframe")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-66-38;y,SCREEN_BOTTOM-9;zoom,1;addx,40;diffusealpha,0;sleep,0.6;decelerate,0.3;addx,-40;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/bpm_dis"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-80;y,SCREEN_BOTTOM-8;zoom,1;diffusealpha,0;sleep,0.65;linear,0.3;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--bpmframe_player2
	t[#t+1] = LoadActor(""..GetGameFrame().."_ScoreFrame/bpmframe")..{
		InitCommand=cmd(rotationy,180;x,SCREEN_CENTER_X+66+38;y,SCREEN_BOTTOM-9;zoom,1;addx,-40;diffusealpha,0;sleep,0.6;decelerate,0.3;addx,40;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenGameplay","ScoreFrame/bpm_dis"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+80;y,SCREEN_BOTTOM-8;zoom,1;diffusealpha,0;sleep,0.65;linear,0.3;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--songmeter_banner
	t[#t+1] = LoadActor(""..GetGameFrame().."_ScoreFrame/bannerframe")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-15;diffusealpha,0;addy,-30;sleep,0.5;decelerate,0.3;addy,30;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--ramp
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		t[#t+1] = LoadActor("scoreframe_ramp")..{
			InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;x,SCREEN_LEFT+18;y,SCREEN_BOTTOM-31;);
			OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_1);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
		};
	end;

	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
		t[#t+1] = LoadActor("scoreframe_ramp")..{
			InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;zoomx,-1;x,SCREEN_RIGHT-18;y,SCREEN_BOTTOM-31;);
			OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_2);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
		};
	end;
end;	

return t;
