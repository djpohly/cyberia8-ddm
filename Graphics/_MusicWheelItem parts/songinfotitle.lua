
local t = Def.ActorFrame{
	LoadFont("","_shared2")..{
		Name="TitleText";
		InitCommand=cmd(horizalign,left;zoomy,0.9;maxwidth,225/1.6;shadowlength,0);
	};
	LoadFont("","_shared2")..{
		Name="SubTitleText";
		InitCommand=cmd(horizalign,left;zoom,0.575;y,14;maxwidth,379/1.6;shadowlength,0);
	};
	LoadFont("","_shared2")..{
		Name="ArtistText";
		InitCommand=cmd(horizalign,left;zoom,0.6;y,20;maxwidth,375/1.6;shadowlength,0);
	};
	SetMessageCommand=function(self, params)
		local titleText = self:GetChild('TitleText');
		local subtitleText = self:GetChild('SubTitleText');
		local artistText = self:GetChild('ArtistText');

		if not GAMESTATE:IsCourseMode() then
			if params.Song then
				local groupcolor = SONGMAN:GetSongGroupColor(params.Song:GetGroupName());
				titleText:diffuse(groupcolor);
				subtitleText:diffuse(groupcolor);
				artistText:diffuse(groupcolor);
				titleText:settext( params.Song:GetDisplayMainTitle() );
				subtitleText:settext( params.Song:GetDisplaySubTitle() );
				artistText:settext( params.Song:GetDisplayArtist() );
				-- no subtitle
				if params.Song:GetDisplaySubTitle() == "" then
					(cmd(x,14;y,-9))(titleText);
					(cmd(diffusealpha,0;x,22))(subtitleText);
					(cmd(x,15;zoom,0.575;y,9))(artistText);
				-- yes subtitle
				else
					(cmd(x,14;zoomy,0.9;y,-23/2))(titleText);
					(cmd(diffusealpha,1;x,22;zoomx,0.575;zoomy,0.565;y,2))(subtitleText);
					(cmd(x,15;zoom,0.6;zoomy,0.565;y,12))(artistText);
				end;
			else
				titleText:settext("");
				subtitleText:settext("");
				artistText:settext("");
			end;
		elseif GAMESTATE:IsCourseMode() then
			if params.Course then
				local numStages = params.Course:GetEstimatedNumStages();
				titleText:diffuse(SONGMAN:GetCourseColor(params.Course));
				titleText:settext(params.Course:GetDisplayFullTitle());
				titleText:x(14);
				titleText:y(-9);
			else
				titleText:settext("");
				subtitleText:settext("");
				artistText:settext("");
			end;
		elseif IsNetConnected() then
			(cmd(settext,params.Title;x,14;zoomy,0.9;y,-23/2))(titleText);
			(cmd(settext,params.Description;x,22;zoomx,0.575;zoomy,0.565;y,2))(subtitleText);
		else
			titleText:settext("");
			subtitleText:settext("");
			artistText:settext("");
		end;
	end;
};

return t;