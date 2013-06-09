--[[MusicGamePlay underlay]]

local t = Def.ActorFrame{};
local pm = GAMESTATE:GetPlayMode();

if not GAMESTATE:IsDemonstration() then
	t[#t+1] = LoadActor("ScreenFilter_Normal")..{
	};
	
	if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			t[#t+1] = LoadActor("tgraph", pn)..{
				InitCommand=cmd(draworder,94;);
			};
		end;
	end;
end;


return t;