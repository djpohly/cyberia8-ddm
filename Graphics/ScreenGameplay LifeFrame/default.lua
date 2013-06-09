--[[ScreenGameplay LifeFrame]]
local t = Def.ActorFrame{};

local setxp1 = SCREEN_CENTER_X - 41;
local setxp2 = SCREEN_CENTER_X + 41;
if GetScreenAspectRatio() >= 2.66666666666666 then
	setxp1 = setxp1 + 0.5;
	setxp2 = setxp2 + 0.5;
end;

local pm = GAMESTATE:GetPlayMode();

if not GAMESTATE:IsDemonstration() then
	t[#t+1] = Def.Quad{
		BeginCommand=cmd(FullScreen);
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("0,0,0,1");linear,1;diffuse,color("0,0,0,0"););
	};

	if pm ~= 'PlayMode_Rave' then
		--percentcover
		t[#t+1] = Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+15;);
			LoadActor(""..GetGameFrame().."_LifeFrame/percentframe_cover")..{
				OnCommand=cmd(horizalign,right;x,-54;diffusealpha,0;addx,30;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,-30;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
			};
			LoadActor(""..GetGameFrame().."_LifeFrame/percentframe_cover")..{
				OnCommand=cmd(horizalign,right;zoomx,-1;x,54;diffusealpha,0;addx,-30;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,30;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
			};
		};
	end;

	--stageframe
	t[#t+1] = LoadActor(""..GetGameFrame().."_LifeFrame/stageframe")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+21;);
		OnCommand=cmd(addy,-60;zoomy,0;sleep,0.3;decelerate,0.3;addy,120/2;zoomy,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	if pm == 'PlayMode_Rave' then
		--combframe
		t[#t+1] = Def.ActorFrame{
			InitCommand=cmd(y,SCREEN_TOP+49;);
			LoadActor("combframe")..{
				InitCommand=cmd(horizalign,left;x,SCREEN_LEFT+42;);
				OnCommand=cmd(addx,-30;diffusealpha,0;sleep,0.3;decelerate,0.3;addx,30;diffusealpha,1;
							glow,color("1,0,0,0");linear,0.05;glow,color("1,0,0,1");linear,0.4;glow,color("1,0,0,0"););
			};
			
			LoadActor("combframe")..{
				InitCommand=cmd(zoomx,-1;horizalign,left;x,SCREEN_RIGHT-42;);
				OnCommand=cmd(addx,30;diffusealpha,0;sleep,0.3;decelerate,0.3;addx,-30;diffusealpha,1;
							glow,color("1,0,0,0");linear,0.05;glow,color("1,0,0,1");linear,0.4;glow,color("1,0,0,0"););
			};
		};
	end;

	--lifeframe_player1
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			if GetGameFrame() == "Csc" or GetGameFrame() == "Csc_Special" then self:y(SCREEN_TOP+35-8);
			else self:y(SCREEN_TOP+35);
			end;
		end;
		OnCommand=cmd(addx,SCREEN_WIDTH*0.6;zoomx,0;zoomy,0.3;accelerate,0.6;addx,-SCREEN_WIDTH*0.6;zoomx,1;decelerate,0.1;zoomy,1;);
		
		LoadActor(""..GetGameFrame().."_LifeFrame/lifeframe_up_width")..{
			OnCommand=cmd(zoomtowidth,SCREEN_WIDTH/2-183-138;horizalign,left;x,SCREEN_LEFT+76;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(""..GetGameFrame().."_LifeFrame/lifeframe_up_left")..{
			OnCommand=cmd(horizalign,left;x,SCREEN_LEFT/2;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(""..GetGameFrame().."_LifeFrame/lifeframe_down_right")..{
			OnCommand=cmd(horizalign,right;x,setxp1;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--lifeframe_player2
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			if GetGameFrame() == "Csc" or GetGameFrame() == "Csc_Special" then self:y(SCREEN_TOP+35-8);
			else self:y(SCREEN_TOP+35);
			end;
		end;
		OnCommand=cmd(addx,SCREEN_WIDTH*0.4;zoomx,0;zoomy,0.3;accelerate,0.6;addx,-SCREEN_WIDTH*0.4;zoomx,1;decelerate,0.1;zoomy,1;);
		LoadActor(""..GetGameFrame().."_LifeFrame/lifeframe_up_width")..{
			OnCommand=cmd(zoomx,-1;zoomtowidth,SCREEN_WIDTH/2-183-137;horizalign,right;x,SCREEN_RIGHT-75;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(""..GetGameFrame().."_LifeFrame/lifeframe_up_left")..{
			OnCommand=cmd(horizalign,left;zoomx,-1;x,SCREEN_RIGHT-2/2+1;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};

		LoadActor(""..GetGameFrame().."_LifeFrame/lifeframe_down_right")..{
			OnCommand=cmd(horizalign,right;zoomx,-1;x,setxp2;sleep,0.7;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
		};
	};

	--stage
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/stage"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+24;y,SCREEN_TOP+38;diffusealpha,0;addx,-20;);
		OnCommand=cmd(sleep,0.5;accelerate,0.4;diffusealpha,1;addx,20;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");linear,0.4;glow,color("1,1,0,0"););
	};

	--ramp
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
		t[#t+1] = LoadActor("lifeframe_ramp")..{
			InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;x,SCREEN_LEFT-1;y,SCREEN_TOP+33;);
			OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_1);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
		};
	end;

	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
		t[#t+1] = LoadActor("lifeframe_ramp")..{
			InitCommand=cmd(diffuse,color("1,0,0,0.5");horizalign,left;zoomx,-1;x,SCREEN_RIGHT+1;y,SCREEN_TOP+33;);
			OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(diffuse,color("1,0,0,0.5");linear,0.5;diffuse,PlayerColor(PLAYER_2);linear,4.5;diffuse,color("1,0,0,0.5");queuecommand,"Repeat";);
		};
	end;
end;

return t;
