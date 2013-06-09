local t = Def.ActorFrame{};

local pn;
if GAMESTATE:IsHumanPlayer(PLAYER_1) then pn = PLAYER_1;
else pn = PLAYER_2;
end;
local playername = GAMESTATE:GetPlayerDisplayName(pn);
local ssStats = STATSMAN:GetPlayedStageStats(1);
local cscgroup = "";
if ssStats then
	cscgroup = ssStats:GetPlayedSongs()[1]:GetGroupName();
end;

local cs_path = "CSDataSave/"..playername.."_Save/0000_co "..cscgroup.."";
local sys_songc = split(":",GetCSCParameter(cscgroup,"Status",playername));
local sys_spoint;
local point = 0;
if File.Read( cs_path ) then
	for k = 1, #sys_songc do
		local sys_spoint = split(",",sys_songc[k]);
		point = point + sys_spoint[2];
	end;
end;
setenv("ccstpoint",point);

t[#t+1] = LoadFont("CourseEntryDisplay","number") .. {
	InitCommand=cmd(horizalign,left;skewx,-0.125;maxwidth,80;shadowlength,0;diffuse,color("0,1,1,1"););
	SetCommand=cmd(settext,point);
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
};

return t;