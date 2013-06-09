local function radarSet(self,player)
	local selection = nil;
	if GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetCurrentCourse() then
			selection = GAMESTATE:GetCurrentTrail(player);
		end;
	else
		if GAMESTATE:GetCurrentSong() then
			selection = GAMESTATE:GetCurrentSteps(player);
		end;
	end;
	if selection then
		self:SetFromRadarValues(player, selection:GetRadarValues(player));
	else
		self:SetEmpty(player);
	end;
end

local t = Def.ActorFrame {
	Name="Radar";
	InitCommand=cmd(x,SCREEN_CENTER_X-320+152;y,330);
	LoadActor( THEME:GetPathG("GrooveRadar", "base") ) .. {
		InitCommand=cmd(zoom,0;rotationz,-360);
		OnCommand=cmd(sleep,0.3;decelerate,0.4;rotationz,0;zoom,1);
	};
	Def.GrooveRadar {
		OnCommand=cmd(zoom,0;sleep,0.583;decelerate,0.150;zoom,1);
		CurrentSongChangedMessageCommand=function(self)
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				radarSet(self, pn);
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=function(self) radarSet(self, PLAYER_1); end;
		CurrentStepsP2ChangedMessageCommand=function(self) radarSet(self, PLAYER_2); end;
		CurrentTrailP1ChangedMessageCommand=function(self) radarSet(self, PLAYER_1); end;
		CurrentTrailP2ChangedMessageCommand=function(self) radarSet(self, PLAYER_2); end;
	};
};

return t;