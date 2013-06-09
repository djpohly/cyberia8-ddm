
local t = Def.ActorFrame{};

local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local p1Steps;
local p2Steps;

local diff_ta = {0,0,0,0,0};
local diff_ma = 92;

local diff = {
	'Difficulty_Beginner',
	'Difficulty_Easy',
	'Difficulty_Medium',
	'Difficulty_Hard',
	'Difficulty_Challenge'
};

local dif_st = {
	Difficulty_Beginner	= 1,
	Difficulty_Easy		= 2,
	Difficulty_Medium	= 3,
	Difficulty_Hard		= 4,
	Difficulty_Challenge	= 5
};

t[#t+1] = LoadActor(THEME:GetPathG("_StepsDisplayListRow cursor", "p2"))..{
	InitCommand=function(self)
		self:playcommand("Set");
	end;
	PlayerJoinedMessageCommand=function(self, params)
		if params.Player == PLAYER_2 then
			self:visible(true);
		end;
	end;
	PlayerUnjoinedMessageCommand=function(self, params)
		if params.Player == PLAYER_2 then
			self:visible(true);
		end;
	end;
	OnCommand=function(self)
		diff_ma = 0;
		self:queuecommand("Set");
	end;
	CurrentStepsP1ChangedMessageCommand=function(self)
		diff_ma = 0;
		self:playcommand("Set");
	end;
	CurrentStepsP2ChangedMessageCommand=function(self)
		diff_ma = 0;
		self:playcommand("Set");
	end;
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
		local dif_unlock = getenv("difunlock_flag");
		p1Steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
		p2Steps = GAMESTATE:GetCurrentSteps(PLAYER_2);
		for difflist = 1, 5 do
			if song then
				if song:HasStepsTypeAndDifficulty(st,diff[difflist]) then
					if dif_unlock[difflist] then
						diff_ma = diff_ma + 92;
						diff_ta[difflist] = diff_ma;
					else
						diff_ma = diff_ma;
						diff_ta[difflist] = 0;
					end;
				else
					diff_ma = diff_ma;
					diff_ta[difflist] = 0;
				end;
			end;
		end;
		self:stoptweening();
		self:decelerate(0.125);
		self:x(diff_ta[dif_st[p2Steps:GetDifficulty()]]);
	end;
	CurrentSongChangedMessageCommand=function(self)
		diff_ma = 0;
		self:queuecommand("Set");
	end;
};

return t;