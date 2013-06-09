local Player = ...
assert(Player,"PersonalRecord needs Player")
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(Player);
local record = stats:GetPersonalHighScoreIndex()
local hasPersonalRecord = record ~= -1

return Def.ActorFrame{
	LoadFont("_shared2")..{
		Text = string.format("#%i", record+1);
		InitCommand=cmd(zoom,0.45;x,10;horizalign,right;diffuse,color("0,1,1,1"));
		BeginCommand=cmd(visible,hasPersonalRecord;);
	};

	LoadFont("_shared2")..{
		Text = string.format("personal", record+1);
		InitCommand=cmd(zoom,0.35;x,-24;y,1;diffuse,color("0,1,1,1"));
		BeginCommand=cmd(visible,hasPersonalRecord;);
	};
};