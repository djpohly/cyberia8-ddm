local t = Def.ActorFrame{};

local limit = getenv("Timer");
local sortorder = GAMESTATE:GetSortOrder();

t[#t+1] = Def.ActorFrame {
--[[
	CodeCommand=function(self,params)
		if params.Name == "Back" then
			self:queuecommand("Off");
		end;
	end;

	LoadActor(THEME:GetPathS("_Screen","cancel")) .. {
		OffCommand=function(self)
			self:stop();
			self:play();
		end;
	};
]]
	LoadActor(THEME:GetPathS("MusicWheel","sort")) .. {
		OnCommand=function(self)
			self:stop();
			self:play();
		end;
	};
};

-- songtitle
t[#t+1] = LoadActor("songinfotitle")..{
	InitCommand=function(self)
		self:stoptweening();
		self:y(SCREEN_CENTER_Y+26);
		if GAMESTATE:IsCourseMode() then self:x(SCREEN_CENTER_X-340);
		else self:x(SCREEN_CENTER_X-240);
		end;
	end;
	OffCommand=cmd(stoptweening;);
};

--[ja] metricsのPrevScreenやNextScreenではメニュータイマーの情報を送れないので対策 (タイムを0にしてから次の画面に移行するため0しか送れない)
--[ja] 画面を行き来する際のソートフラグ
t[#t+1] = Def.ActorFrame{
	CodeMessageCommand=function(self,params)
		if limit > 10 then
			if params.Name == "Start" or params.Name == "Center" then
				setenv("SortCh",getenv("POSort"));
				SCREENMAN:SetNewScreen("ScreenSelectMusic");
			elseif params.Name == "Back" then
				--SCREENMAN:GetTopScreen():Cancel();
				--SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToPrevScreen', 0)
				if getenv("psflag") ~= "" then
					setenv("SortCh",getenv("psflag"));
				else
					setenv("SortCh",ToEnumShortString(sortorder));
				end;
				SCREENMAN:SetNewScreen("ScreenSelectMusic");
			end;
		end;
	end;
};
--clock
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+58;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;);
	BeginCommand=function(self)
		(cmd(settext, string.format("%04i/%i/%i %i:%02i", Year(), MonthOfYear()+1,DayOfMonth(), Hour(), Minute());sleep,1;queuecommand,"Begin"))(self)
	end;
};

return t;