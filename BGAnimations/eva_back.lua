local t = Def.ActorFrame{};

local jacketPath ,sbannerpath ,cdimagepath ,sbackgroundpath ,cbannerpath ,cbackgroundpath;

local showbanner = PREFSMAN:GetPreference('ShowBanners');
local showjacket = GetAdhocPref("ShowJackets");

function GetSongImage(song,course)
	if song then
		jacketpath = song:GetJacketPath()
		sbannerpath = song:GetBannerPath()
		cdimagepath = song:GetCDImagePath()
		sbackgroundpath = song:GetBackgroundPath()

		if showbanner then
			if showjacket == "On" then
				if jacketpath then return jacketpath
				elseif sbannerpath then return sbannerpath
				elseif cdimagepath then return cdimagepath
				elseif sbackgroundpath then return backgroundpath
				end
			elseif sbannerpath then return sbannerpath
			end
		end
	elseif course then
		cbannerpath = course:GetBannerPath()
		cbackgroundpath = course:GetBackgroundPath()

		if showbanner then
			if cbannerpath then return cbannerpath
			end
		end
	end
	return THEME:GetPathG("Common","fallback jacket");
end

function GetSongImageSize(song,course)
	if song then
		jacketpath = song:GetJacketPath()
		sbannerpath = song:GetBannerPath()
		cdimagepath = song:GetCDImagePath()
		sbackgroundpath = song:GetBackgroundPath()

		if showbanner then
			if showjacket == "On" then
				if jacketpath then return 160
				elseif sbannerpath then return 50
				elseif cdimagepath then return 160
				elseif sbackgroundpath then return 160
				end
			elseif sbannerpath then
				return 50
			end
		end
	elseif course then
		cbannerpath = course:GetBannerPath()
		cbackgroundpath = course:GetBackgroundPath()

		if showbanner then
			if showjacket == "On" then
				if cbannerpath then return 50
				elseif cbackgroundpath then return 160	
				end
			elseif cbannerpath then return 50
			end
		end
	end
	return 160;
end

function GetSongBackground(song,course)
	if song then
		sbackgroundpath = song:GetBackgroundPath()
		return sbackgroundpath
	elseif course then
		cbackgroundpath = course:GetBackgroundPath()
		return cbackgroundpath
	end
	return THEME:GetPathG("Common","fallback background");
end

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:fov(100);
		self:y(SCREEN_CENTER_Y+100);
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
		not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
			self:x(SCREEN_RIGHT-(SCREEN_WIDTH*0.54));
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
		not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
			self:x(SCREEN_LEFT+(SCREEN_WIDTH*0.54));
		else
			self:x(SCREEN_RIGHT-(SCREEN_WIDTH*0.54));
		end;
	end;

--banner_background
	Def.ActorFrame{
		InitCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
			not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
				(cmd(rotationz,20;))(self)
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
			not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
				(cmd(rotationz,-20;))(self)
			else
				(cmd(rotationz,20;))(self)
			end;
		end;
--		OnCommand=cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;);
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
			not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
				(cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;))(self)
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
			not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
				(cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,-130;rotationz,-200;))(self)
			else
				(cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;))(self)
			end;
		end;
		Def.Banner {
			InitCommand=cmd(y,-110;diffusealpha,0.5;vertalign,bottom;);
			OnCommand=function(self, params)
				local songorcourse;
				if GAMESTATE:IsCourseMode() then
					songorcourse = GAMESTATE:GetCurrentCourse();
				else
					songorcourse = GAMESTATE:GetCurrentSong();
				end;
				self:Load(GetSongBackground(songorcourse,songorcourse));
				local gw = self:GetWidth();
				local gh = self:GetHeight();
				local graphicAspect = gw/gh
				local dwidth = 480 * graphicAspect;
				dwidth = dwidth * (GetScreenAspectRatio() / 5);
				local dheight = 480;
				dheight = dheight * (GetScreenAspectRatio() / 5);
				self:scaletoclipped(dwidth,dheight);
				self:diffusetopedge(color("1,1,1,0.5"));
				self:diffusebottomedge(color("1,1,1,0.5"));
	
				if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
				not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
					(cmd(diffuserightedge,color("1,1,1,0.4");horizalign,left;))(self)
				elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
				not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
					(cmd(diffuseleftedge,color("1,1,1,0.4");horizalign,right;))(self)
				else
					(cmd(diffuserightedge,color("1,1,1,0.4");horizalign,left;))(self)
				end;
			end;
		};

		Def.Banner {
			InitCommand=cmd(diffusealpha,0.5;);
			OnCommand=function(self, params)
				self:diffusetopedge(color("1,1,1,0.5"));
				self:diffusebottomedge(color("1,1,1,0.5"));

				if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
				not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
					(cmd(diffuserightedge,color("1,1,1,0.4");horizalign,left;))(self)
				elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
				not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
					(cmd(diffuseleftedge,color("1,1,1,0.4");horizalign,right;))(self)
				else
					(cmd(diffuserightedge,color("1,1,1,0.4");horizalign,left;))(self)
				end;

				local songorcourse;
				if GAMESTATE:IsCourseMode() then
					songorcourse = GAMESTATE:GetCurrentCourse();
				else
					songorcourse = GAMESTATE:GetCurrentSong();
				end;
				if not songorcourse:GetBackgroundPath() then
					self:y(-160);
					self:Load(GetSongImage(songorcourse,songorcourse));
					self:zoomtowidth(160*1.4);
					self:zoomtoheight(GetSongImageSize(songorcourse,songorcourse)*1.4);
				else
					self:y(-100);
					self:vertalign(top);
					self:Load(GetSongImage(songorcourse,songorcourse));
					self:zoomtowidth(160);
					self:zoomtoheight(GetSongImageSize(songorcourse,songorcourse));
				end;
			end;
		};
	};
};

return t;