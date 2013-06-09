--[[ Infostatus ]]
local Player = ...
assert(Player,"Must pass in a player, dingus");

local t = Def.ActorFrame{
	Name="Infostatus"..Player;
	BeginCommand=function(self)
		self:visible(GAMESTATE:IsHumanPlayer(Player));
	end;
	PlayerJoinedMessageCommand=function(self,param)
		if param.Player == Player then
			self:visible(true);
		end;
	end;
	PlayerUnjoinedMessageCommand=function(self,param)
		if param.Player == Player then
			self:visible(false);
		end;
	end;
};
	t[#t+1] = Def.ActorFrame{
		LoadActor("help")..{
			OnCommand=function(self)
				if Player == PLAYER_1 then
					(cmd(diffusealpha,0;addx,30;zoom,1.35;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,-30;zoom,1;))(self)
				else
					(cmd(diffusealpha,0;addx,-30;zoom,1.35;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,30;zoom,1;))(self)
				end;
			end;
			OffCommand=cmd(stoptweening;);
		};
	};

t[#t+1] = Def.ActorFrame {};

return t;