return Def.BPMDisplay {
	File=THEME:GetPathF("","BPMDisplay");
	Name="BPMDisplay";
	SetCommand=function(self)
		self:visible(true);
		self:SetFromGameState();
		if getenv("rnd_song") == 1 then
			self:visible(false);
		end;
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
};