local t = Def.ActorFrame {
	--song length
	LoadFont("_numbers3") ..{
		InitCommand=cmd(horizalign,right;vertalign,bottom;shadowlength,0;maxwidth,124;);
		OnCommand=cmd(zoomx,0.7;sleep,0.9;decelerate,0.4;zoomy,0.7;playcommand,"Set");
		SetCommand=function(self)
			local SongOrCourse;
			local timeText = "x:xx.xx";
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
			end;
			if getenv("rnd_song") == 1 then
				timeText = "x:xx.xx";
			elseif SongOrCourse then
				if GAMESTATE:IsCourseMode() then
					local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
					if trail then
						local st = trail:GetStepsType();
						if st then
							timeText = SecondsToMSSMsMs(TrailUtil.GetTotalSeconds(trail));
						else
							timeText = "x:xx.xx";
						end;
					else
						timeText = "x:xx.xx";
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
	
	--machine rank
	LoadFont("PaneDisplay text") ..{
		InitCommand=cmd(x,-22;y,7;horizalign,right;shadowlength,0;diffuse,color("0,1,1,1");maxwidth,60;);
		OnCommand=cmd(zoomy,0;sleep,1.1;decelerate,0.4;zoom,1;playcommand,"Set");
		SetCommand=function(self)
			if not GAMESTATE:IsCourseMode() then
				local song = GAMESTATE:GetCurrentSong();
				if getenv("rnd_song") == 1 then
					self:visible(false);
				elseif song then
					local rank = SONGMAN:GetSongRank(song);
					self:visible(true);
					self:settext(rank);
				else
					self:visible(false);
				end;
			else
				self:visible(false);	
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	};
};

return t;