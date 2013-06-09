local t = Def.ActorFrame {
	LoadFont("_numbers1") ..{
		InitCommand=cmd(horizalign,right;;skewx,-0.125;shadowlength,0;maxwidth,200;SetTextureFiltering,false;zoom,0.725;diffuse,color("1,1,0,1"););
		OnCommand=cmd(zoom,0.75;zoomy,0;sleep,0.9;decelerate,0.4;zoomy,0.725;playcommand,"Set");
		SetCommand=function(self)
			local SongOrCourse = nil;
			local timeText = "??:??.??";
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
			end;
			if SongOrCourse then
				if GAMESTATE:IsCourseMode() then
					local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
					if trail then
						local st = trail:GetStepsType();
						if st then
							timeText = SecondsToMSSMsMs(TrailUtil.GetTotalSeconds(trail));
						else
							timeText = "??:??.??";
						end;
					else
						timeText = "??:??.??";
					end;
				else
					timeText = SecondsToMSSMsMs(SongOrCourse:MusicLengthSeconds());
				end;
			else
				timeText = "";
			end;
			self:settext(timeText);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	};
	
};

return t;