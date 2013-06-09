--[[ ScreenWithMenuElements Statusbar ]]

local t = Def.ActorFrame{};
local screen = SCREENMAN:GetTopScreen();

t[#t+1] = Def.ActorFrame {
	OnCommand=function(self)
		if THEME:GetMetric( Var "LoadingScreen","ScreenType") == 2 then self:playcommand("NoAnim");
		else self:playcommand("Anim");
		end;
	end;
	--player 1
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X*0.575-34;y,SCREEN_BOTTOM-28;);
		LoadActor("at")..{
			AnimCommand=cmd(diffusealpha,0;zoom,1.35;sleep,0.5;decelerate,0.3;diffusealpha,1;zoom,1;);
			NoAnimCommand=cmd(diffusealpha,1;zoom,1;);
			OffCommand=cmd(diffusealpha,1;zoom,1;accelerate,0.3;diffusealpha,0;zoom,1.35;);
		};

		Def.ActorFrame{
			InitCommand=cmd(player,PLAYER_1);
			PlayerJoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_1 then
					self:visible(true);
				end;
			end;
			PlayerUnjoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_1 then
					self:visible(false);
				end;
			end;
			LoadActor("ramp")..{
				AnimCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");queuecommand,"Repeat";);
				NoAnimCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");queuecommand,"Repeat";);
				RepeatCommand=cmd(sleep,6;linear,0.05;diffusealpha,1;glow,color("0,1,1,1");decelerate,2.5;diffusealpha,0;glow,color("0,0,0,0");queuecommand,"Repeat";);
				OffCommand=cmd(stoptweening;);
			};
			LoadActor("p1")..{
				InitCommand=cmd(x,-103;y,-5;);
				AnimCommand=cmd(diffusealpha,0;zoom,1.35;sleep,0.5;decelerate,0.3;diffusealpha,1;zoom,1;);
				NoAnimCommand=cmd(diffusealpha,1;zoom,1;);
				OffCommand=cmd(diffusealpha,1;zoom,1;accelerate,0.3;diffusealpha,0;zoom,1.35;);
			};
		};
	};
	
	--player 2
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X*1.425+20;y,SCREEN_BOTTOM-28;);
		LoadActor("at")..{
			AnimCommand=cmd(diffusealpha,0;zoom,1.35;sleep,0.5;decelerate,0.3;diffusealpha,1;zoom,1;);
			NoAnimCommand=cmd(diffusealpha,1;zoom,1;);
			OffCommand=cmd(diffusealpha,1;zoom,1;accelerate,0.3;diffusealpha,0;zoom,1.35;);
		};
		
		Def.ActorFrame{
			InitCommand=cmd(player,PLAYER_2);
			PlayerJoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_2 then
					self:visible(true);
				end;
			end;
			PlayerUnjoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_2 then
					self:visible(false);
				end;
			end;
			LoadActor("ramp")..{
				AnimCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");queuecommand,"Repeat";);
				NoAnimCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");queuecommand,"Repeat";);
				RepeatCommand=cmd(sleep,6;linear,0.05;diffusealpha,1;glow,color("0,1,1,1");decelerate,2.5;diffusealpha,0;glow,color("0,0,0,0");queuecommand,"Repeat";);
				OffCommand=cmd(stoptweening;);
			};
			LoadActor("p2")..{
				InitCommand=cmd(x,-103;y,-5;);
				AnimCommand=cmd(diffusealpha,0;zoom,1.35;sleep,0.5;decelerate,0.3;diffusealpha,1;zoom,1;);
				NoAnimCommand=cmd(diffusealpha,1;zoom,1;);
				OffCommand=cmd(diffusealpha,1;zoom,1;accelerate,0.3;diffusealpha,0;zoom,1.35;);
			};
		};
	};
};

return t;