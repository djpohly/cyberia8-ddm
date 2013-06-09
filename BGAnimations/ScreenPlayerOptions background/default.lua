local t = Def.ActorFrame{};

--[ja] 選曲画面でタイムのフラグとして使います
setenv("sortflag",0);

if GAMESTATE:IsExtraStage() and getenv("exflag") == "csc" then
	t[#t+1] = LoadActor(THEME:GetPathB("ScreenSelectMusicCS","background"))..{
	};
elseif GAMESTATE:IsExtraStage() and getenv("exflag") ~= "csc" then
	t[#t+1] = LoadActor("extra1")..{
	};
elseif GAMESTATE:IsExtraStage2() then
	t[#t+1] = LoadActor("extra2")..{
	};
else
	t[#t+1] = LoadActor(THEME:GetPathB("ScreenWithMenuElements","background"))..{
	};
end;

return t;