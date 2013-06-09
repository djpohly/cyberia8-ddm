local t=Def.ActorFrame{};

local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local meter = "";

local diff = {
	'Difficulty_Beginner',
	'Difficulty_Easy',
	'Difficulty_Medium',
	'Difficulty_Hard',
	'Difficulty_Challenge'
};

local diff_ma = 0;
local diff_ta = {0,0,0,0,0};

for difflist = 1, 5 do
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			self:visible(false);
			diff_ma = 0;
			self:playcommand("Set");
		end;
		BeginCommand=function(self)
			self:visible(false);
			diff_ma = 0;
			self:playcommand("Set");
		end;
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local dif_unlock = getenv("difunlock_flag");
			if song then
				if song:HasStepsTypeAndDifficulty(st,diff[difflist]) then
					if dif_unlock[difflist] then
						self:visible(true);
						diff_ma = diff_ma + 46;
						diff_ta[difflist] = diff_ma;
					else
						self:visible(false);
						diff_ma = diff_ma;
						diff_ta[difflist] = 10000;
					end;
				else
					self:visible(false);
					diff_ma = diff_ma;
					diff_ta[difflist] = 10000;
				end;
			end;
			self:y(diff_ta[difflist]);
		end;
		OnCommand=function(self)
			self:visible(false);
			diff_ma = 0;
			self:queuecommand("Set");
		end;
		CurrentSongChangedMessageCommand=function(self)
			self:visible(false);
			diff_ma = 0;
			self:queuecommand("Set");
		end;

		LoadActor(THEME:GetPathG("", "_difftable"))..{
			InitCommand=function(self)
				(cmd(visible,false;animate,false;setstate,0;playcommand,"Set"))(self)
			end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				local dif_unlock = getenv("difunlock_flag");
				if song then
					self:setstate(difflist-1);
					if song:HasStepsTypeAndDifficulty(st,diff[difflist]) then
						if dif_unlock[difflist] then
							self:visible(true);
						else
							self:visible(false);
						end;
					else
						self:visible(false);
					end;
				end;
			end;
		};

		Def.ActorFrame{
			InitCommand=cmd(x,6;y,-32);
			LoadFont("StepsDisplay meter")..{
				InitCommand=function(self)
					self:settext("");
					(cmd(visible,false;shadowlength,0;rotationz,90;horizalign,left;maxwidth,60;zoom,0.8;skewx,-0.175;playcommand,"Set"))(self)
				end;
				BeginCommand=function(self)
					self:visible(false);
					self:playcommand("Set");
				end;
				SetCommand=function(self)
					local song = GAMESTATE:GetCurrentSong();
					local dif_unlock = getenv("difunlock_flag");
					if song then
						if song:HasStepsTypeAndDifficulty(st,diff[difflist]) then
							if dif_unlock[difflist] then
								self:visible(true);
								if GetAdhocPref("UserMeterType") == "CSStyle" then
									meter = GetConvertDifficulty(song,diff[difflist]);
								else
									meter = song:GetOneSteps(st,diff[difflist]):GetMeter();
								end;
								self:diffuse(Colors.Difficulty[diff[difflist]]);
								self:settextf("%d",meter);
							else
								self:settext("");
								self:visible(false);
							end;
						else
							self:settext("");
							self:visible(false);
						end;
					else
						self:settext("");
						self:visible(false);
					end;
				end;
				OnCommand=function(self)
					self:visible(false);
					self:playcommand("Set");
				end;
				CurrentSongChangedMessageCommand=function(self)
					self:visible(false);
					self:queuecommand("Set");
				end;
			};
		};
	};
end;
return t;