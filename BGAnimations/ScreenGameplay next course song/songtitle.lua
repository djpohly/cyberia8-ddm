
local t = Def.ActorFrame{};

local coursemode = GAMESTATE:IsCourseMode();
local showjacket = GetAdhocPref("ShowJackets");

-- songtitle_plus_subtile
t[#t+1] = LoadFont("_shared2")..{
	Name="SongMainTitle1";
	BeforeLoadingNextCourseSongMessageCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
		self:diffuse( groupcolor );
		if song:GetDisplaySubTitle() ~= "" then
			self:settext(song:GetDisplayMainTitle());
			(cmd(maxwidth,225*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-50;horizalign,right;zoomx,1;zoomy,0.9;shadowlength,2))(self)
		else
			self:settext(song:GetDisplayFullTitle());
			(cmd(maxwidth,225*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-40;horizalign,right;zoom,1;shadowlength,2))(self)
		end;
	end;
	StartCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
			addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-150;diffusealpha,0;);
	FinishCommand=cmd(finishtweening;diffusealpha,0;);
};
-- songtitle_plus_subtile
t[#t+1] = LoadFont("_shared2")..{
	Name="SongMainTitle2";
	BeforeLoadingNextCourseSongMessageCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
		self:diffuse( groupcolor );
		if song:GetDisplaySubTitle() ~= "" then
			self:settext(song:GetDisplayMainTitle());
			(cmd(maxwidth,225*1.75;x,SCREEN_CENTER_X-192;horizalign,left;zoomx,1;zoomy,0.9;shadowlength,2))(self)
		else
			self:settext(song:GetDisplayFullTitle());
			(cmd(maxwidth,225*1.75;x,SCREEN_CENTER_X-192;horizalign,left;zoom,1;shadowlength,2))(self)
		end;
	end;
	StartCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		if song:GetDisplaySubTitle() ~= "" then
			self:y(SCREEN_CENTER_Y+20);
			if showjacket == "On" then
				local songorcourse = SCREENMAN:GetTopScreen():GetNextCourseSong();
				local sbannerpath = songorcourse:GetBannerPath();
				local sjacketpath = songorcourse:GetJacketPath();
				local scdimagepath = songorcourse:GetCDImagePath();
				if not sbannerpath then self:y(SCREEN_BOTTOM-80-20);
				elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-80-20);
				end;
			end;
		else
			self:y(SCREEN_CENTER_Y+30);
			if showjacket == "On" then
				local songorcourse = SCREENMAN:GetTopScreen():GetNextCourseSong();
				local sbannerpath = songorcourse:GetBannerPath();
				local sjacketpath = songorcourse:GetJacketPath();
				local scdimagepath = songorcourse:GetCDImagePath();
				if not sbannerpath then self:y(SCREEN_BOTTOM-70-20);
				elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-70-20);
				end;
			end;
		end;

		(cmd(addx,-200;diffusealpha,0;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.3;addx,12;diffusealpha,0))(self)
	end;
	FinishCommand=cmd(finishtweening;diffusealpha,0;);
};
-- songtitle_plus_subtile
t[#t+1] = LoadFont("_shared2")..{
	Name="SongSubTitle1";
	BeforeLoadingNextCourseSongMessageCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
		if song:GetDisplaySubTitle() ~= "" then
			self:diffuse( groupcolor );
			self:settext(song:GetDisplaySubTitle());
			(cmd(maxwidth,379*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-34;horizalign,right;zoomx,0.575;zoomy,0.565;shadowlength,2))(self)
		else
			self:diffusealpha(0);
		end;
	end;
	StartCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		if song:GetDisplaySubTitle() ~= "" then
			(cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
			addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-300/2;diffusealpha,0;))(self)
		else
			self:diffusealpha(0);
		end;
	end;
	FinishCommand=cmd(finishtweening;diffusealpha,0;);
};
-- songtitle_plus_subtile
t[#t+1] = LoadFont("_shared2")..{
	Name="SongSubTitle2";
	BeforeLoadingNextCourseSongMessageCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
		if song:GetDisplaySubTitle() ~= "" then
			self:diffuse( groupcolor );
			self:settext(song:GetDisplaySubTitle());
			(cmd(maxwidth,379*1.75;x,SCREEN_CENTER_X-192;horizalign,left;zoomx,0.575;zoomy,0.565;shadowlength,2))(self)
		else
			self:diffusealpha(0);
		end;
	end;
	StartCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		if song:GetDisplaySubTitle() ~= "" then
			self:y(SCREEN_CENTER_Y+36);
			if showjacket == "On" then
				local songorcourse = SCREENMAN:GetTopScreen():GetNextCourseSong();
				local sbannerpath = songorcourse:GetBannerPath();
				local sjacketpath = songorcourse:GetJacketPath();
				local scdimagepath = songorcourse:GetCDImagePath();
				if not sbannerpath then self:y(SCREEN_BOTTOM-64-20);
				elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-64-20);
				end;
			end;
			(cmd(addx,-200;diffusealpha,0;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.1;addx,18;diffusealpha,0))(self)
		else
			self:diffusealpha(0);
		end;
	end;
	FinishCommand=cmd(finishtweening;diffusealpha,0;);
};

-- artist
t[#t+1] = LoadFont("_shared2")..{
	Name="Artist1";
	BeforeLoadingNextCourseSongMessageCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
		self:diffuse( groupcolor );
		self:settext(song:GetDisplayArtist());
		(cmd(horizalign,right;shadowlength,2;maxwidth,375*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-20;zoom,0.65;shadowlength,2))(self)
	end;
	StartCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
				addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-300/2;diffusealpha,0);
	FinishCommand=cmd(finishtweening;diffusealpha,0;);
};
-- artist
t[#t+1] = LoadFont("_shared2")..{
	Name="Artist2";
	BeforeLoadingNextCourseSongMessageCommand=function(self)
		local song = SCREENMAN:GetTopScreen():GetNextCourseSong();
		local groupcolor = SONGMAN:GetSongGroupColor(song:GetGroupName());
		self:diffuse( groupcolor );
		self:settext(song:GetDisplayArtist());
		(cmd(horizalign,left;shadowlength,2;maxwidth,375*1.75;x,SCREEN_CENTER_X-192;horizalign,left))(self)
	end;
	StartCommand=function(self)
		self:y(SCREEN_CENTER_Y+50);
		if showjacket == "On" then
			local songorcourse = SCREENMAN:GetTopScreen():GetNextCourseSong();
			local sbannerpath = songorcourse:GetBannerPath();
			local sjacketpath = songorcourse:GetJacketPath();
			local scdimagepath = songorcourse:GetCDImagePath();
			if not sbannerpath then self:y(SCREEN_BOTTOM-50-20);
			elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-50-20);
			end;
		end;
		(cmd(addx,-200;diffusealpha,0;zoom,0.65;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.2;addx,16;diffusealpha,0))(self)
	end;
	FinishCommand=cmd(finishtweening;diffusealpha,0;);
};

return t;