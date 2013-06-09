local t = Def.ActorFrame{};

if THEME:GetMetric( Var "LoadingScreen","Summary" ) == false then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		t[#t+1] = LoadActor("fullcomboeva", pn);
	end;
end;

return t;
