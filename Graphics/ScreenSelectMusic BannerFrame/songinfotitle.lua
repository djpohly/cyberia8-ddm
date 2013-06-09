local t = Def.ActorFrame{
	LoadFont("","_shared2")..{
		Name="GroupText";
		InitCommand=cmd(horizalign,center;zoomy,0.9;y,-2;maxwidth,225;shadowlength,0);
	};
	LoadFont("","_shared2")..{
		Name="TitleText";
		InitCommand=cmd(horizalign,left;zoomy,0.9;maxwidth,225;shadowlength,0);
	};
	LoadFont("","_shared2")..{
		Name="SubTitleText";
		InitCommand=cmd(horizalign,left;zoom,0.575;y,14;maxwidth,379;shadowlength,0);
	};
	LoadFont("","_shared2")..{
		Name="ArtistText";
		InitCommand=cmd(horizalign,left;zoom,0.6;y,20;maxwidth,375;shadowlength,0);
	};
	SetCommand=function(self)
		self:stoptweening();
		local groupText  = self:GetChild('GroupText');	
		local titleText  = self:GetChild('TitleText');
		local subtitleText = self:GetChild('SubTitleText');
		local artistText = self:GetChild('ArtistText');
		local ssStats = STATSMAN:GetPlayedStageStats(1);
		
		local song = GAMESTATE:GetCurrentSong();
		local course = GAMESTATE:GetCurrentCourse();
		local screen = SCREENMAN:GetTopScreen();
		if not GAMESTATE:IsCourseMode() then
			if not IsNetConnected() then
				local envgroup = getenv("wheelsectiongroup");
				local envsort = getenv("wheelsectionsort");
				local envrandom = getenv("wheelsectionrandom");
				local envcsc = getenv("wheelsectioncsc");
				local sortm = GAMESTATE:GetSortOrder();
				local musicwheel = SCREENMAN:GetTopScreen():GetMusicWheel();
			--[[
				if sortm == 'SortOrder_Roulette' then
					self:sleep(1);
					SetCurrentSong(self:GetRandomSong());
					SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToNextScreen',0);
				end;
			]]
				if song then
					local bExtra1 = GAMESTATE:IsExtraStage();
					local bExtra2 = GAMESTATE:IsExtraStage2();
					local style = GAMESTATE:GetCurrentStyle();
					local extrasong, extrasteps = SONGMAN:GetExtraStageInfo( bExtra2, style );

					local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
					local extracolor = THEME:GetMetric("MusicWheel","SongRealExtraColor");
					
					if ( bExtra1 or bExtra2 ) and extrasong == song then
						titleText:diffuse(extracolor);
						subtitleText:diffuse(extracolor);
						artistText:diffuse(extracolor);
					else	
						titleText:diffuse(groupcolor);
						subtitleText:diffuse(groupcolor);
						artistText:diffuse(groupcolor);
					end;
					
					titleText:settext( song:GetDisplayMainTitle() );
					subtitleText:settext( song:GetDisplaySubTitle() );
					artistText:settext( song:GetDisplayArtist() );
					groupText:settext("");
					-- no subtitle
					if song:GetDisplaySubTitle() == "" then
						subtitleText:settext("");
						groupText:settext("");
						(cmd(finishtweening;x,9+3;linear,0.15;x,14+3;y,-9))(titleText);
						(cmd(finishtweening;x,17+3;linear,0.15;diffusealpha,0;x,22+3))(subtitleText);
						(cmd(finishtweening;x,20+3;linear,0.15;x,15+3;zoom,0.575;y,9))(artistText);
					-- yes subtitle
					else
						groupText:settext("");
						(cmd(finishtweening;x,9+2;y,-9;linear,0.15;zoomy,0.9;x,14+3;y,-23/2))(titleText);
						(cmd(finishtweening;x,17+3;diffusealpha,0;linear,0.15;diffusealpha,1;x,22+3;zoomx,0.575;zoomy,0.565;y,2))(subtitleText);
						(cmd(finishtweening;x,20+3;y,9;linear,0.15;x,15+3;zoom,0.6;zoomy,0.565;y,12))(artistText);
					end;
				elseif envgroup ~= "" then
					if sortm == 'SortOrder_Group' then
						groupText:settext(envgroup);
						groupText:diffuse(SONGMAN:GetSongGroupColor(envgroup));
					else
						groupText:settext(envgroup);
						groupText:diffuse(color("0.5,1,0.1,1"));
					end;
					(cmd(finishtweening;x,116+9;linear,0.15;x,116+14;))(groupText);
					titleText:settext("");	
					subtitleText:settext("");
					artistText:settext("");
				elseif envrandom and musicwheel:GetSelectedType() == 'WheelItemDataType_Random' then 
					groupText:settext(envrandom);
					groupText:diffuse(THEME:GetMetric("MusicWheel","RandomColor"));
					(cmd(finishtweening;x,116+9;linear,0.15;x,116+14;))(groupText);
					titleText:settext("");	
					subtitleText:settext("");
					artistText:settext("");
				elseif envcsc and musicwheel:GetSelectedType() == 'WheelItemDataType_Custom' then
					groupText:settext(""); 
					subtitleText:settext("");
					titleText:settext(envcsc);
					titleText:diffuse(THEME:GetMetric("MusicWheel","CSCColor"));
					artistText:diffuse(THEME:GetMetric("MusicWheel","CSCColor"));
					if ssStats then
						artistText:settext( ssStats:GetPlayedSongs()[1]:GetGroupName() );
					else
						artistText:settext("Beginner's Package");	
					end;
					(cmd(finishtweening;x,9+3;linear,0.15;x,14+3;y,-9))(titleText);
					(cmd(finishtweening;x,20+3;linear,0.15;x,15+3;zoom,0.575;y,9))(artistText);
				elseif sortm == 'SortOrder_ModeMenu' or screen:GetName() == "ScreenSort" then
					local sortmenu = envsort;
					groupText:settext(envsort);
					groupText:diffuse(GetSortColor(sortmenu));
					(cmd(finishtweening;x,116+9;linear,0.15;x,116+14;))(groupText);
					titleText:settext("");	
					subtitleText:settext("");
					artistText:settext("");
				else
					groupText:settext("");
					titleText:settext("");	
					subtitleText:settext("");
					artistText:settext("");
				end;
			else
				local envgroup = getenv("wheelsectiongroup");
				local envsort = getenv("wheelsectionsort");
				local envrandom = getenv("wheelsectionrandom");
				local envcsc = getenv("wheelsectioncsc");
				local sortm = GAMESTATE:GetSortOrder();
			--[[
				if sortm == 'SortOrder_Roulette' then
					self:sleep(1);
					SetCurrentSong(self:GetRandomSong());
					SCREENMAN:GetTopScreen():PostScreenMessage('SM_GoToNextScreen',0);
				end;
			]]
				if song then
					local bExtra1 = GAMESTATE:IsExtraStage();
					local bExtra2 = GAMESTATE:IsExtraStage2();
					local style = GAMESTATE:GetCurrentStyle();
					local extrasong, extrasteps = SONGMAN:GetExtraStageInfo( bExtra2, style );

					local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
					local extracolor = THEME:GetMetric("MusicWheel","SongRealExtraColor");
					
					if ( bExtra1 or bExtra2 ) and extrasong == song then
						titleText:diffuse(extracolor);
						subtitleText:diffuse(extracolor);
						artistText:diffuse(extracolor);
					else	
						titleText:diffuse(groupcolor);
						subtitleText:diffuse(groupcolor);
						artistText:diffuse(groupcolor);
					end;
					
					titleText:settext( song:GetDisplayMainTitle() );
					subtitleText:settext( song:GetDisplaySubTitle() );
					artistText:settext( song:GetDisplayArtist() );
					groupText:settext("");
					-- no subtitle
					if song:GetDisplaySubTitle() == "" then
						subtitleText:settext("");
						groupText:settext("");
						(cmd(finishtweening;x,9+3;linear,0.15;x,14+3;y,-9))(titleText);
						(cmd(finishtweening;x,17+3;linear,0.15;diffusealpha,0;x,22+3))(subtitleText);
						(cmd(finishtweening;x,20+3;linear,0.15;x,15+3;zoom,0.575;y,9))(artistText);
					-- yes subtitle
					else
						groupText:settext("");
						(cmd(finishtweening;x,9+2;y,-9;linear,0.15;zoomy,0.9;x,14+3;y,-23/2))(titleText);
						(cmd(finishtweening;x,17+3;diffusealpha,0;linear,0.15;diffusealpha,1;x,22+3;zoomx,0.575;zoomy,0.565;y,2))(subtitleText);
						(cmd(finishtweening;x,20+3;y,9;linear,0.15;x,15+3;zoom,0.6;zoomy,0.565;y,12))(artistText);
					end;
				elseif envgroup ~= "" then
					if sortm == 'SortOrder_Group' then
						groupText:settext(envgroup);
						groupText:diffuse(SONGMAN:GetSongGroupColor(envgroup));
					else
						groupText:settext(envgroup);
						groupText:diffuse(color("0.5,1,0.1,1"));
					end;
					(cmd(finishtweening;x,116+9;linear,0.15;x,116+14;))(groupText);
					titleText:settext("");	
					subtitleText:settext("");
					artistText:settext("");
				elseif sortm == 'SortOrder_ModeMenu' or screen:GetName() == "ScreenSort" then
					local sortmenu = envsort;
					groupText:settext(envsort);
					groupText:diffuse(GetSortColor(sortmenu));
					(cmd(finishtweening;x,116+9;linear,0.15;x,116+14;))(groupText);
					titleText:settext("");	
					subtitleText:settext("");
					artistText:settext("");
				else
					groupText:settext("");
					titleText:settext("");	
					subtitleText:settext("");
					artistText:settext("");
				end;
			end;
		elseif GAMESTATE:IsCourseMode() then
			if course then
				local numStages = course:GetEstimatedNumStages();
				groupText:diffuse(SONGMAN:GetCourseColor(course));
				groupText:settext(course:GetDisplayFullTitle());
				(cmd(finishtweening;x,116+9;linear,0.15;x,116+14;))(groupText);
			else
				groupText:settext("");
				titleText:settext("");
				subtitleText:settext("");
				artistText:settext("");
			end;
		else
			groupText:settext("");
			titleText:settext("");
			subtitleText:settext("");
			artistText:settext("");
			return;
		end;
	end;
	OffCommand=cmd(stoptweening;);
	UpdateCommand=cmd(playcommand,"Set";);
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
};

return t;