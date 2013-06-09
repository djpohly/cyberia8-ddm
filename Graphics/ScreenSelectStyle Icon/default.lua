--[[ScreenSelectStyle Icon]]

local gc = Var "GameCommand";

local t = Def.ActorFrame{
	Def.ActorFrame{
		LoadActor("icon_decide1")..{
			InitCommand=cmd(x,-26;y,-6;);
			OffCommand=cmd(linear,0.1;diffusealpha,0);
			GainFocusCommand=cmd(finishtweening;diffusealpha,1;cropright,1;cropleft,0;sleep,0.1;linear,0.2;cropright,0;);
			LoseFocusCommand=cmd(finishtweening;cropleft,0;cropright,0;sleep,0.1;accelerate,0.1;cropleft,1;diffusealpha,0;);
		};

		LoadActor("icon_decide4")..{
			InitCommand=cmd(x,2;y,2;);
			OffCommand=cmd(linear,0.1;diffusealpha,0;);
			GainFocusCommand=cmd(finishtweening;visible,true;diffusealpha,1;croptop,1;linear,0.2;croptop,0;glowshift;effectcolor1,color("1,0,0,1");effectcolor2,color("0.5,0,0.4,0.8");effectperiod,1);
			LoseFocusCommand=cmd(diffusealpha,1;linear,0.25;diffusealpha,0);
		};
	};
	Def.ActorFrame{
		--iconbase
		LoadActor(gc:GetName())..{
			OffCommand=cmd(linear,0.1;diffusealpha,0);
			GainFocusCommand=cmd(finishtweening;linear,0.2;diffuse,color("1,1,1,1"););
			LoseFocusCommand=cmd(linear,0.1;diffuse,color("0.45,0.45,0.45,1"););
		};
		
		LoadActor(THEME:GetPathG("","stylemodeback/icon_decide2"))..{
			InitCommand=cmd(x,34;y,42);
			OffCommand=cmd(linear,0.1;diffusealpha,0);
			GainFocusCommand=cmd(finishtweening;diffusealpha,1;croptop,0;cropbottom,1;decelerate,0.15;cropbottom,0;);
			LoseFocusCommand=cmd(finishtweening;cropbottom,0;croptop,0;sleep,0.1;accelerate,0.1;croptop,1;diffusealpha,0;);
		};

		--iconfocusglow
		LoadActor(gc:GetName())..{
			OnCommand=function(self)
				if GAMESTATE:GetNumPlayersEnabled() == 2 then
					if IsNetConnected() then
						if gc:GetName() == "Double" then
							self:playcommand("GainFocus");
						end;
					elseif gc:GetName() == "Single" or gc:GetName() == "Solo" then
						self:playcommand("LoseFocus");
					elseif gc:GetName() == "Versus" then
						self:playcommand("GainFocus");
					end;
				elseif gc:GetName() == "Single" then
					self:playcommand("GainFocus");
				end;
			end;
			OffCommand=cmd(linear,0.1;diffusealpha,0;);
			GainFocusCommand=cmd(finishtweening;diffusealpha,1;glow,color("1,1,0,0.6");croptop,1;cropbottom,1;linear,0.4;croptop,0;linear,0.2;cropbottom,0;linear,0.2;croptop,1;queuecommand,"Sleep";);
			SleepCommand=cmd(sleep,4;queuecommand,"GainFocus";);
			LoseFocusCommand=cmd(finishtweening;diffusealpha,0;);
		};
	};
};
return t;