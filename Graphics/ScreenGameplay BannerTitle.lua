--[ja] ジャケット表示できるけどスペースの都合で大きさが小さいので実用向きではない
--[[
local jacketPath ,cdimagepath ,sbannerpath;

local showbanner = PREFSMAN:GetPreference('ShowBanners');
local showjacket = GetAdhocPref("ShowJackets");

function GetSongImage(song)
	if song then
		jacketpath = song:GetJacketPath()
		sbannerpath = song:GetBannerPath()
		cdimagepath = song:GetCDImagePath()

		if showbanner then
			if showjacket then
				if jacketpath then
					return jacketpath
				elseif sbannerpath then
					return sbannerpath
				elseif cdimagepath then
					return cdimagepath
				end
			elseif sbannerpath then
				return sbannerpath
			end
		end
	end
	return THEME:GetPathG("common fallback","banner");
end

function GetSongImageSize(song)
	if song then
		jacketpath = song:GetJacketPath()
		sbannerpath = song:GetBannerPath()
		cdimagepath = song:GetCDImagePath()

		if showbanner then
			if showjacket then
				if jacketpath then
					return 40,40
				elseif sbannerpath then
					return 104,30
				elseif cdimagepath then
					return 40,40
				end
			elseif sbannerpath then
				return 104,30
			end
		end
	end
	return 104,30;
end

function SongImageY(song)
	if song then
		jacketpath = song:GetJacketPath()
		sbannerpath = song:GetBannerPath()
		cdimagepath = song:GetCDImagePath()

		if showbanner then
			if showjacket then
				if jacketpath then
					return SCREEN_BOTTOM-22
				elseif sbannerpath then
					return SCREEN_BOTTOM-26
				elseif cdimagepath then
					return SCREEN_BOTTOM-22
				end
			elseif sbannerpath then
				return SCREEN_BOTTOM-20
			end
		end
	end
	return SCREEN_BOTTOM-20;
end


local t = Def.ActorFrame{
	Def.Banner {
		Name="Banner";
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if not song then
				self:Load( THEME:GetPathG("common fallback","banner") );
			else
				self:Load(GetSongImage(song));
			end;
			self:ScaleToClipped(GetSongImageSize(song));
			(cmd(x,SCREEN_CENTER_X;y,SongImageY(song);))(self)
		end;
		InitCommand=cmd(queuecommand,"Set");
		OnCommand=cmd(diffusealpha,0;addy,-20;sleep,0.7;decelerate,0.5;diffusealpha,0.8;addy,20;);
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
};

return t;
]]

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Banner {
		Name="Banner";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-26;ScaleToClipped,104,30);
		OnCommand=cmd(diffusealpha,0;addy,-20;sleep,0.7;decelerate,0.5;diffusealpha,0.8;addy,20;);
		SetSongCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local sbanner = song:HasBanner();
			local sbannerpath = song:GetBannerPath();
			self:visible(false);
			if not song then
				self:visible(false);
			elseif sbanner then
				self:visible(true);
				self:LoadFromSong(song);
			end;
		end;
		UpdateCommand=cmd(playcommand,"SetSong");
		CurrentSongChangedMessageCommand=cmd(playcommand,"SetSong");
	};

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-26;playcommand,"SetSong";);
		LoadActor(THEME:GetPathB("ScreenSelectMusic","background/_bannerback2"))..{
			InitCommand=cmd(y,4;zoomx,10;zoomy,0;);
			OnCommand=cmd(sleep,0.2;decelerate,0.3;zoom,0.6;);
			SetSongCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				local sbanner = song:HasBanner();
				local sbannerpath = song:GetBannerPath();
				self:visible(false);
				if not sbanner then
					self:visible(true);
				end;
			end;
			UpdateCommand=cmd(playcommand,"SetSong");
			CurrentSongChangedMessageCommand=cmd(playcommand,"SetSong");
		};

		Def.TextBanner {
			InitCommand=cmd(x,-90;Load,"GamePlayTextBanner";SetFromString,"", "", "", "", "", "";playcommand,"SetSong";);
			OnCommand=cmd(zoomx,0.7;zoomy,0;sleep,0.6;decelerate,0.4;zoomy,0.7;);
			SetSongCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				local sbanner = song:HasBanner();
				local sbannerpath = song:GetBannerPath();
				self:visible(false);
				if not sbanner then
					self:visible(true);
					self:SetFromSong( song );
					self:diffuse( SONGMAN:GetSongColor( song ) );
				end;
			end;
			UpdateCommand=cmd(playcommand,"SetSong";);
			CurrentSongChangedMessageCommand=cmd(playcommand,"SetSong";);
		};
	};
};

return t;