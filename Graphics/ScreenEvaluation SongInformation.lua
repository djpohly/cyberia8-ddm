local t = Def.ActorFrame{
	Def.TextBanner {
		InitCommand=cmd(Load,"EvaluationTextBanner";SetFromString,"", "", "", "", "", "";);
		OnCommand=function(self)
			(cmd(zoomx,0.8;zoomy,0;sleep,0.6;decelerate,0.4;zoomy,0.8))(self)
			local song = GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse();
			local coursemode = GAMESTATE:IsCourseMode();
			self:visible(true);
			if coursemode then
				self:y(8);
				if course then
					self:SetFromString( course:GetDisplayFullTitle(), "", "", "", "", "" );
					self:diffuse( SONGMAN:GetCourseColor( course ) );
				end;
			else
				self:y(0);			
				if song then
					self:SetFromSong( song );
					local bExtra1 = GAMESTATE:IsExtraStage();
					local bExtra2 = GAMESTATE:IsExtraStage2();
					local style = GAMESTATE:GetCurrentStyle();
					local extrasong, extrasteps = SONGMAN:GetExtraStageInfo( bExtra2, style );

					local groupcolor = SONGMAN:GetSongColor( song );
					local extracolor = THEME:GetMetric("MusicWheel","SongRealExtraColor");
				
					if ( bExtra1 or bExtra2 ) and extrasong == song then
						self:diffuse(extracolor);
					else	
						self:diffuse(groupcolor);
					end;
				end;
			end;
		end;
	};
};
return t;
