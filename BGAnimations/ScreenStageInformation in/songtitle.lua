
local t = Def.ActorFrame{
};

local coursemode = GAMESTATE:IsCourseMode();
local songorcourse;
local sjacketPath ,sbannerpath ,scdimagepath, cbannerpath;
local songorcoursecolor;

if coursemode then
	songorcourse = GAMESTATE:GetCurrentCourse();
	cbannerpath = songorcourse:GetBannerPath();
	songorcoursecolor = SONGMAN:GetCourseColor(songorcourse);
else
	songorcourse = GAMESTATE:GetCurrentSong();
	sbannerpath = songorcourse:GetBannerPath();
	sjacketpath = songorcourse:GetJacketPath();
	scdimagepath = songorcourse:GetCDImagePath();
	songorcoursecolor = SONGMAN:GetSongColor(songorcourse);
end;

local bExtra1 = GAMESTATE:IsExtraStage();
local bExtra2 = GAMESTATE:IsExtraStage2();
local style = GAMESTATE:GetCurrentStyle();
local extrasong, extrasteps = SONGMAN:GetExtraStageInfo( bExtra2, style );
local extracolor = THEME:GetMetric("MusicWheel","SongRealExtraColor");

local showjacket = GetAdhocPref("ShowJackets");

if not coursemode then
	if GAMESTATE:GetCurrentSong():GetDisplaySubTitle() ~= "" then
		-- songtitle_plus_subtile
		t[#t+1] = LoadFont("_shared2")..{
			Name="SongMainTitle1";
			Text=GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
			InitCommand=function(self)
				self:diffuse(songorcoursecolor);
				if getenv("exflag") ~= "csc" then
					if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
						self:diffuse(extracolor);
					end;
				end;
				(cmd(maxwidth,225*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-50;horizalign,right;zoomx,1;zoomy,0.9;shadowlength,2))(self)
			end;
			OnCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
						addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-150;diffusealpha,0;);
		};
		-- songtitle_plus_subtile
		t[#t+1] = LoadFont("_shared2")..{
			Name="SongMainTitle2";
			Text=GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
			InitCommand=function(self)
				self:diffuse(songorcoursecolor);
				if getenv("exflag") ~= "csc" then
					if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
						self:diffuse(extracolor);
					end;
				end;
				(cmd(maxwidth,225*1.75;x,SCREEN_CENTER_X-192;horizalign,left;zoomx,1;zoomy,0.9;shadowlength,2))(self)
			end;
			OnCommand=function(self)
				self:y(SCREEN_CENTER_Y+20);
				if showjacket == "On" then
					if not sbannerpath then self:y(SCREEN_BOTTOM-80);
					elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-80);
					end;
				end;
				(cmd(addx,-200;diffusealpha,0;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.3;addx,12;diffusealpha,0))(self)
			end;
		};
		-- songtitle_plus_subtile
		t[#t+1] = LoadFont("_shared2")..{
			Name="SongSubTitle1";
			Text=GAMESTATE:GetCurrentSong():GetDisplaySubTitle();
			InitCommand=function(self)
				self:diffuse(songorcoursecolor);
				if getenv("exflag") ~= "csc" then
					if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
						self:diffuse(extracolor);
					end;
				end;
				(cmd(maxwidth,379*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-34;horizalign,right;zoomx,0.575;zoomy,0.565;shadowlength,2))(self)
			end;
			OnCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
						addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-300/2;diffusealpha,0;);
		};
		-- songtitle_plus_subtile
		t[#t+1] = LoadFont("_shared2")..{
			Name="SongSubTitle2";
			Text=GAMESTATE:GetCurrentSong():GetDisplaySubTitle();
			InitCommand=function(self)
				self:diffuse(songorcoursecolor);
				if getenv("exflag") ~= "csc" then
					if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
						self:diffuse(extracolor);
					end;
				end;
				(cmd(maxwidth,379*1.75;x,SCREEN_CENTER_X-192;horizalign,left;zoomx,0.575;zoomy,0.565;shadowlength,2))(self)
			end;
			OnCommand=function(self)
				self:y(SCREEN_CENTER_Y+36);
				if showjacket == "On" then
					if not sbannerpath then self:y(SCREEN_BOTTOM-64);
					elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-64);
					end;
				end;
				(cmd(addx,-200;diffusealpha,0;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.1;addx,18;diffusealpha,0))(self)
			end;
		};
	else
		-- full title
		t[#t+1] = LoadFont("_shared2")..{
			Name="SongTitle1";
			Text=GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
			InitCommand=function(self)
				self:diffuse(songorcoursecolor);
				if getenv("exflag") ~= "csc" then
					if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
						self:diffuse(extracolor);
					end;
				end;
				(cmd(maxwidth,225*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-40;horizalign,right;zoom,1;shadowlength,2))(self)
			end;
			OnCommand=cmd(shadowlength,2;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
						addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-300/2;diffusealpha,0;);
		};
		-- full title
		t[#t+1] = LoadFont("_shared2")..{
			Name="SongTitle2";
			Text=GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
			InitCommand=function(self)
				self:diffuse(songorcoursecolor);
				if getenv("exflag") ~= "csc" then
					if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
						self:diffuse(extracolor);
					end;
				end;
				(cmd(maxwidth,225*1.75;x,SCREEN_CENTER_X-192;horizalign,left;zoom,1;shadowlength,2))(self)
			end;
			OnCommand=function(self)
				self:y(SCREEN_CENTER_Y+30);
				if showjacket == "On" then
					if not sbannerpath then self:y(SCREEN_BOTTOM-70);
					elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-70);
					end;
				end;
				(cmd(addx,-200;diffusealpha,0;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.1;addx,12;diffusealpha,0))(self)
			end;
		};
	end;

	-- artist
	t[#t+1] = LoadFont("_shared2")..{
		Name="Artist1";
		Text=GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=function(self)
			self:diffuse(songorcoursecolor);
			if getenv("exflag") ~= "csc" then
				if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
					self:diffuse(extracolor);
				end;
			end;
			(cmd(horizalign,right;shadowlength,2;maxwidth,375*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-20;zoom,0.65;shadowlength,2))(self)
		end;
		OnCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
					addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-300/2;diffusealpha,0);
	};
	-- artist
	t[#t+1] = LoadFont("_shared2")..{
		Name="Artist2";
		Text=GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=function(self)
			self:diffuse(songorcoursecolor);
			if getenv("exflag") ~= "csc" then
				if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
					self:diffuse(extracolor);
				end;
			end;
			(cmd(horizalign,left;shadowlength,2;maxwidth,375*1.75;x,SCREEN_CENTER_X-192;horizalign,left))(self)
		end;
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+50);
			if showjacket == "On" then
				if not sbannerpath then self:y(SCREEN_BOTTOM-50);
				elseif sbannerpath and (sjacketpath or scdimagepath) then self:y(SCREEN_BOTTOM-50);
				end;
			end;
			(cmd(addx,-200;diffusealpha,0;zoom,0.65;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.2;addx,16;diffusealpha,0))(self)
		end;
	};
else
	-- full title
	t[#t+1] = LoadFont("_shared2")..{
		Name="SongTitle1";
		Text=GAMESTATE:GetCurrentCourse():GetDisplayFullTitle();
		InitCommand=function(self)
			self:diffuse(songorcoursecolor);
			if getenv("exflag") ~= "csc" then
				if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
					self:diffuse(extracolor);
				end;
			end;
			(cmd(maxwidth,225*1.75;x,SCREEN_RIGHT-20;y,SCREEN_CENTER_Y-40;horizalign,right;zoom,1;shadowlength,2))(self)
		end;
		OnCommand=cmd(diffusealpha,0;addx,SCREEN_WIDTH*0.5;sleep,0.2;accelerate,0.4;diffusealpha,1;
					addx,-SCREEN_WIDTH*0.5;sleep,1.4;accelerate,0.1;addy,-150;diffusealpha,0;);
	};
	-- full title
	t[#t+1] = LoadFont("_shared2")..{
		Name="SongTitle2";
		Text=GAMESTATE:GetCurrentCourse():GetDisplayFullTitle();
		InitCommand=function(self)
			self:diffuse(songorcoursecolor);
			if getenv("exflag") ~= "csc" then
				if ( bExtra1 or bExtra2 ) and extrasong == songorcourse then
					self:diffuse(extracolor);
				end;
			end;
			(cmd(maxwidth,225*1.75;x,SCREEN_CENTER_X-192;horizalign,left;zoom,1;shadowlength,2))(self)
		end;
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+30);
			if showjacket == "On" then
				if cbannerpath then
					if string.find(cbannerpath,"jacket") then self:y(SCREEN_BOTTOM-70);
					end;
				else self:y(SCREEN_BOTTOM-70);
				end;
			end;
			(cmd(addx,-200;diffusealpha,0;sleep,2;accelerate,0.1;addx,200;diffusealpha,1;sleep,0.6+0.5;accelerate,0.3;addx,12;diffusealpha,0))(self)
		end;
	};
end;

return t;