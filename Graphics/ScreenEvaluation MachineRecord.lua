local Player = ...
assert(Player,"MachineRecord needs Player")
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(Player);
local record = stats:GetMachineHighScoreIndex()
local hasMachineRecord = record ~= -1

return Def.ActorFrame{
	LoadFont("_shared2")..{
		Text = string.format("#%i", record+1);
		InitCommand=cmd(zoom,0.45;x,10;horizalign,right;);
		BeginCommand=cmd(visible,hasMachineRecord);
	};

	LoadFont("_shared2")..{
		Text = string.format("machine", record+1);
		InitCommand=cmd(zoom,0.35;x,-24;y,1;);
		BeginCommand=cmd(visible,hasMachineRecord);
	};
};