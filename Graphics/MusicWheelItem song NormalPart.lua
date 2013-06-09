
local showbanner = PREFSMAN:GetPreference('ShowBanners');
local showjacket = GetAdhocPref("ShowJackets");
local cjacket = THEME:GetPathG("Common","fallback jacket");
local cbanner = THEME:GetPathG("Common","fallback banner");
local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local ac = 1;
--setenv("sortset","")

local t = Def.ActorFrame{};

	--back
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(linear,0.4;playcommand,"Flag";);
	FlagCommand=function(self) ac = 0;
	end;
	SetMessageCommand=function(self, params)
		local items = math.floor((SCREEN_WIDTH/150)*2) + 2;
		if ac == 1 then
			if params.DrawIndex > math.floor(items / 2) then
				(cmd(addx,400;zoomx,0;decelerate,(items -1 - params.DrawIndex)*0.02;addx,-400;zoomx,1;))(self)
			elseif params.DrawIndex < math.floor(items / 2) then
				(cmd(addx,-400;zoomx,0;decelerate,params.DrawIndex*0.02;addx,400;zoomx,1;))(self)
			elseif params.DrawIndex == math.floor(items / 2) then
				(cmd(zoomy,0;decelerate,0.2;zoomy,1;))(self)
			end;
		end;
	end;
	Def.Quad{
		InitCommand=cmd(y,100;diffuse,color("0,0,0,0.5");diffusetopedge,color("0,0,0,0.5");
					diffusebottomedge,color("0,0,0,0");zoomtowidth,160;zoomtoheight,160/4;);
	};
	
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,0.3");diffusetopedge,color("0,0,0,0.3");
					diffusebottomedge,color("0,0,0,0.8");zoomtowidth,160;zoomtoheight,160;);
	};

	--jacket_mirror
	Def.Banner {
		Name="Banner";
		InitCommand=cmd(y,100;rotationy,180;rotationz,180;diffusetopedge,color("0,0,0,0");diffusebottomedge,color("1,1,1,0.5"));
		SetMessageCommand=function(self, params)
			local song = params.Song;
			local course = params.Course;
			local path = nil;
			local zoom = 160;
			local rate = 1;
			if song then
				if showbanner then
					if showjacket == "On" then
						path = cjacket;
						if song:GetJacketPath() then 
							path = song:GetJacketPath();
						elseif song:GetBannerPath() then
							path = song:GetBannerPath();
							rate = 0.2;
							zoom = 50;
						elseif song:GetBackgroundPath() then
							path = song:GetBackgroundPath();
						elseif song:GetCDImagePath() then
							path = song:GetCDImagePath();
						end;
					else
						path = cbanner;
						zoom = 50;
						if song:GetBannerPath() then
							path = song:GetBannerPath();
							rate = 0.2;
						end;
					end;
				else
					path = cbanner;
					zoom = 50;
				end;
			elseif course then
				if showbanner then
					if showjacket == "On" then
						path = cjacket;
						if course:GetBannerPath() then
							path = course:GetBannerPath();
							if string.find(course:GetBannerPath(),"jacket") then
								zoom = 160;
							else
								zoom = 50;
								rate = 0.2;
							end;
						elseif course:GetBackgroundPath() then
							path = course:GetBackgroundPath();
						end
					else
						path = cbanner;
						zoom = 50;
						if course:GetBannerPath() then
							path = course:GetBannerPath();
							if string.find(course:GetBannerPath(),"jacket") then
								zoom = 160;
							else
								rate = 0.2;
							end;
						end;
					end;
				else
					path = cbanner;
					zoom = 50;
				end;
			end;
			self:Load(path);
			self:zoomtowidth(160);
			self:zoomtoheight(zoom/4);
			self:rate(rate);
			setenv("SongImage",path);
			setenv("SongImageSize",zoom);
			setenv("SongImageRate",rate);
		end;
	};
	
	--jacket
	Def.Banner {
		Name="Banner";
		SetMessageCommand=function(self, params)
			local song = params.Song;
			local course = params.Course;
			if song or course then
				self:Load(getenv("SongImage"));
			end;
			self:zoomtowidth(160);
			self:zoomtoheight(getenv("SongImageSize"));
			self:rate(getenv("SongImageRate"));
		end;
	};
	
	--white
	LoadActor(THEME:GetPathG("","bannercover1"))..{
		InitCommand=cmd(vertalign,bottom;y,SCREEN_CENTER_Y-220;zoomtowidth,160;zoomtoheight,40;diffusealpha,0.6;blend,'BlendMode_Add';);
	};
	
	--title
	Def.ActorFrame{
		SetMessageCommand=function(self, params)
			self:visible(false);
			local song = params.Song;
			local course = params.Course;
			if song then
				if getenv("SongImage") == cjacket or
				getenv("SongImage") == cbanner then
					if not params.HasFocus then self:visible(true);
					end;
				end;
				setenv("indexnum",params.Index);
			elseif course then
				if getenv("SongImage") == cjacket or
				getenv("SongImage") == cbanner then
					if not params.HasFocus then self:visible(true);
					end;
				end;
		--[[
			elseif IsNetConnected() then
				if params.HasFocus then
					self:visible(false);
				else
					self:visible(true);
				end;
		]]
			end;
		end;

		Def.Quad {
			InitCommand=cmd(y,66;zoomtowidth,160;zoomtoheight,80;diffuse,color("0,0,0,0.7");diffusebottomedge,color("0,0,0,0"));
		};
		LoadActor(THEME:GetPathG("_MusicWheelItem","parts/songinfotitle"))..{
			InitCommand=cmd(x,-84;y,46;);
		};
	};
	
	--ramp
	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/ramp"))..{
		InitCommand=cmd(x,-66.5;y,-77;zoomy,1;);
		SetMessageCommand=function(self, params)
			local song = params.Song;
			self:visible(false);
			if song then
				self:visible(true);
				self:diffuse( SONGMAN:GetSongGroupColor(song:GetGroupName()) );
			end;
		end;
	};

--[[
	LoadFont("_shared2")..{
		InitCommand=cmd(maxwidth,146;shadowlength,0);
		SetMessageCommand=function(self,params)
			self:settext(params.DrawIndex);
		end;
	};
]]
};

return t;