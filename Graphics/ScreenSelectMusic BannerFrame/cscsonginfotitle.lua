local t = Def.ActorFrame{
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
		
		local song = getenv("cs_song");
		local songtitle = getenv("load_songtitle");
		local songartist = getenv("load_songartist");
		local screen = SCREENMAN:GetTopScreen();
		if not GAMESTATE:IsCourseMode() then
			if song then
				local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
				titleText:diffuse(groupcolor);
				subtitleText:diffuse(groupcolor);
				artistText:diffuse(groupcolor);
				titleText:settext( song:GetDisplayMainTitle() );
				subtitleText:settext( song:GetDisplaySubTitle() );
				if songartist then artistText:settext( songartist );
				else artistText:settext( song:GetDisplayArtist() );
				end;
				-- no subtitle
				if songtitle then
					titleText:settext( songtitle );
					subtitleText:settext("");
					(cmd(finishtweening;x,9+3;linear,0.15;x,14+3;y,-9))(titleText);
					(cmd(finishtweening;x,17+3;linear,0.15;diffusealpha,0;x,22+3))(subtitleText);
					(cmd(finishtweening;x,20+3;linear,0.15;x,15+3;zoom,0.575;y,9))(artistText);			
				elseif song:GetDisplaySubTitle() == "" then
					titleText:settext( song:GetDisplayMainTitle() );
					subtitleText:settext("");
					(cmd(finishtweening;x,9+3;linear,0.15;x,14+3;y,-9))(titleText);
					(cmd(finishtweening;x,17+3;linear,0.15;diffusealpha,0;x,22+3))(subtitleText);
					(cmd(finishtweening;x,20+3;linear,0.15;x,15+3;zoom,0.575;y,9))(artistText);
				-- yes subtitle
				else
					(cmd(finishtweening;x,9+2;y,-9;linear,0.15;zoomy,0.9;x,14+3;y,-23/2))(titleText);
					(cmd(finishtweening;x,17+3;diffusealpha,0;linear,0.15;diffusealpha,1;x,22+3;zoomx,0.575;zoomy,0.565;y,2))(subtitleText);
					(cmd(finishtweening;x,20+3;y,9;linear,0.15;x,15+3;zoom,0.6;zoomy,0.565;y,12))(artistText);
				end;
			else
				titleText:settext("");	
				subtitleText:settext("");
				artistText:settext("");
			end;
		else
			titleText:settext("");	
			subtitleText:settext("");
			artistText:settext("");	
		end;
	end;
	OnCommand=cmd(playcommand,"Set";);
	OffCommand=cmd(stoptweening;);
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
};

return t;