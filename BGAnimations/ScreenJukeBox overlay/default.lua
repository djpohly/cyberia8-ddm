local t = Def.ActorFrame{};

local jacketPath ,sbannerpath ,cdimagepath ,sbackgroundpath ,cbannerpath ,cbackgroundpath;

local showbanner = PREFSMAN:GetPreference('ShowBanners');
local showjacket = GetAdhocPref("ShowJackets");

function GetSongImage(song)
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
	end
	return THEME:GetPathG("Common","fallback jacket");
end

function GetSongImageSize(song,params)
	if song then
		jacketpath = song:GetJacketPath()
		sbannerpath = song:GetBannerPath()
		cdimagepath = song:GetCDImagePath()
		sbackgroundpath = song:GetBackgroundPath()

		if showbanner then
			if showjacket == "On" then
				if jacketpath then return 160,160
				elseif sbannerpath then return 192,60
				elseif cdimagepath then return 160,160
				elseif sbackgroundpath then return 160,160
				end
			elseif sbannerpath then return 192,60
			end
		end
	end
	return 160,160;
end

if GAMESTATE:IsDemonstration() then
	t[#t+1] = LoadActor("jukeback")..{
		InitCommand=cmd(horizalign,right;vertalign,bottom;x,SCREEN_RIGHT;y,SCREEN_BOTTOM-38;shadowlength,0;);
		OnCommand=cmd(diffusealpha,0;addx,300;sleep,0.6;decelerate,0.4;diffusealpha,1;addx,-300;);
	};

	t[#t+1] = Def.Banner{
		Name="SongJacket";
		InitCommand=function(self, params)
			(cmd(horizalign,right;vertalign,bottom;shadowlength,2;
			x,SCREEN_RIGHT-28;y,SCREEN_BOTTOM-68;diffusetopedge,color("1,1,1,0.8")))(self)
			local song = GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse();
			if song or course then
				self:Load(GetSongImage(song,course));
			end;
		end;
		OnCommand=function(self, params)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				(cmd(diffusealpha,0;zoomx,1;zoomy,0;sleep,0.8;accelerate,0.2;diffusealpha,0.8;zoomto,GetSongImageSize(song)))(self)
			end;
		end;
	};

	t[#t+1] = Def.TextBanner {
		InitCommand=cmd(Load,"DemoTextBanner";SetFromString,"", "", "", "", "", "";);
		OnCommand=cmd(x,SCREEN_RIGHT-38;y,SCREEN_BOTTOM-46;zoomx,0.8;zoomy,0;sleep,0.6;decelerate,0.4;zoomy,0.8;);
		SetSongCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse();
			local coursemode = GAMESTATE:IsCourseMode();
			self:visible(true);
			if coursemode then
				if course then
					self:SetFromString( course:GetDisplayFullTitle(), "", "", "", "", "" );
					self:diffuse( SONGMAN:GetCourseColor( course ) );
				end;
			else					
				if song then
					self:SetFromSong( song );
					self:diffuse( SONGMAN:GetSongColor( song ) );
				end;
			end;
		end;
		UpdateCommand=cmd(playcommand,"SetSong";);
		CurrentSongChangedMessageCommand=cmd(playcommand,"SetSong";);
	};

t[#t+1] = LoadActor(THEME:GetPathB("","premium"))..{
};
end;

return t;