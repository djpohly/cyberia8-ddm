local showbanner = PREFSMAN:GetPreference('ShowBanners');
local showjacket = GetAdhocPref("ShowJackets");
local cjacket = THEME:GetPathG("Common","fallback jacket");
local cbanner = THEME:GetPathG("Common","fallback banner");
local sctext = getenv("SortCh");
local ac = 1;
local titletable = {
	A		= 2,
	B		= 3,
	C		= 4,
	D		= 5,
	E		= 6,
	F		= 7,
	G		= 8,
	H		= 9,
	I		= 10,
	J		= 11,
	K		= 12,
	L		= 13,
	M		= 14,
	N		= 15,
	O		= 16,
	P		= 17,
	Q		= 18,
	R		= 19,
	S		= 20,
	T		= 21,
	U		= 22,
	V		= 23,
	W		= 24,
	X		= 25,
	Y		= 26,
	Z		= 27,
	Other	= 28
};

local t = Def.ActorFrame{
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
	Def.ActorFrame{
		Def.Quad{
			OnCommand=cmd(y,100;diffuse,color("0,0,0,0.7");diffusetopedge,color("0,0,0,0.7");
						diffusebottomedge,color("0,0,0,0");zoomtowidth,160;zoomtoheight,160/4;);
		};
		
		Def.Quad{
			OnCommand=cmd(diffuse,color("0,0,0,0.6");diffusetopedge,color("0,0,0,0.6");
						diffusebottomedge,color("0,0,0,0.9");zoomtowidth,160;zoomtoheight,160;);
		};

	};

	Def.Banner {
		Name="GroupJacket";
		InitCommand=cmd(diffusealpha,1;y,100;rotationy,180;rotationz,180;);
		SetMessageCommand=function(self, params)
			local group = params.Text;
			local grouppath = SONGMAN:GetSongGroupBannerPath(group);
			local path = nil;
			local zoom = 50;
			local rate = 1;
			local extension = {"png","jpg","jpeg","gif","bmp"};
			if group and GAMESTATE:GetSortOrder() == 'SortOrder_Group' then
				if showbanner then
					if showjacket == "On" then
						for i=1,#extension do
							if FILEMAN:DoesFileExist("/Songs/"..group.."/jacket."..extension[i]) then
								path = "/Songs/"..group.."/jacket."..extension[i];
								zoom = 160;
								do break; end;
							elseif FILEMAN:DoesFileExist("/AdditionalSongs/"..group.."/jacket."..extension[i]) then
								path = "/AdditionalSongs/"..group.."/jacket."..extension[i];
								zoom = 160;
								break;
							end;
						end;
						if path == nil then
							if grouppath ~= "" then
								path = grouppath;
								rate = 0.2;
							else
								path = cjacket;
								zoom = 160;
							end;
						end;
					else
						path = grouppath;
					end;
				else
					path = cbanner;
				end;
			else
				path = THEME:GetPathG("_MusicWheelItem","parts/section_mono_banner");
				if showjacket == "On" then
					path = THEME:GetPathG("_MusicWheelItem","parts/section_mono_jacket");
					zoom = 160;
				end;
			end;
			
			self:Load(path);
			self:diffusetopedge(color("0,0,0,0"));
			if group and
			(GAMESTATE:GetSortOrder() == 'SortOrder_Title' or GAMESTATE:GetSortOrder() == 'SortOrder_Artist') then
				if group == '0-9' then
					self:diffusebottomedge(HSVA( (360/28)*1,0.5,1,0.5 ));
				else
					self:diffusebottomedge(HSVA( (360/28)*titletable[group],1,0.5,1,0.5 ));
				end;
			elseif sctext == "TopGrades" then
				if group == THEME:GetString("Grade","Tier01") then self:diffusebottomedge( Colors.Grade["Tier01"] );
				elseif group == THEME:GetString("Grade","Tier02") then self:diffusebottomedge( Colors.Grade["Tier02"] );
				elseif group == THEME:GetString("Grade","Tier03") then self:diffusebottomedge( Colors.Grade["Tier03"] );
				elseif group == THEME:GetString("Grade","Tier04") then self:diffusebottomedge( Colors.Grade["Tier04"] );
				elseif group == THEME:GetString("Grade","Tier05") then self:diffusebottomedge( Colors.Grade["Tier05"] );
				elseif group == THEME:GetString("Grade","Tier06") then self:diffusebottomedge( Colors.Grade["Tier06"] );
				elseif group == THEME:GetString("Grade","Tier07") then self:diffusebottomedge( Colors.Grade["Tier07"] );
				elseif group == THEME:GetString("Grade","Failed") then self:diffusebottomedge( Colors.Grade["Failed"] );
				elseif group == THEME:GetString("Grade","NoneSectionText") then self:diffusebottomedge( Colors.Grade["None"] );
				end;
			else
				if sctext == "BeginnerMeter" then self:diffusebottomedge( Colors.Difficulty["Beginner"] );
				elseif sctext == "EasyMeter" then self:diffusebottomedge( Colors.Difficulty["Easy"] );
				elseif sctext == "MediumMeter" then self:diffusebottomedge( Colors.Difficulty["Medium"] );
				elseif sctext == "HardMeter" then self:diffusebottomedge( Colors.Difficulty["Hard"] );
				elseif sctext == "ChallengeMeter" then self:diffusebottomedge( Colors.Difficulty["Challenge"] );
				else self:diffusebottomedge(color("1,1,1,0.5"));
				end;
			end;
			self:zoomtowidth(160);
			self:zoomtoheight(zoom/4);
			self:rate(rate);
			setenv("GroupImage",(path));
			setenv("GroupImageSize",(zoom));
			setenv("GroupImageRate",rate);
		end;
	};

	Def.Banner {
		Name="GroupJacket";
		InitCommand=cmd(diffusealpha,1;);
		SetMessageCommand=function(self, params)
			local group = params.Text;
			if group and
			(GAMESTATE:GetSortOrder() == 'SortOrder_Title' or GAMESTATE:GetSortOrder() == 'SortOrder_Artist') then
				if group == '0-9' then
					self:diffuse(HSV( (360/28)*1,0.5,1 ));
				else
					self:diffuse(HSV( (360/28)*titletable[group],1,0.5,1 ));
				end;
			elseif sctext == "TopGrades" then
				if group == THEME:GetString("Grade","Tier01") then self:diffuse( Colors.Grade["Tier01"] );
				elseif group == THEME:GetString("Grade","Tier02") then self:diffuse( Colors.Grade["Tier02"] );
				elseif group == THEME:GetString("Grade","Tier03") then self:diffuse( Colors.Grade["Tier03"] );
				elseif group == THEME:GetString("Grade","Tier04") then self:diffuse( Colors.Grade["Tier04"] );
				elseif group == THEME:GetString("Grade","Tier05") then self:diffuse( Colors.Grade["Tier05"] );
				elseif group == THEME:GetString("Grade","Tier06") then self:diffuse( Colors.Grade["Tier06"] );
				elseif group == THEME:GetString("Grade","Tier07") then self:diffuse( Colors.Grade["Tier07"] );
				elseif group == THEME:GetString("Grade","Failed") then self:diffuse( Colors.Grade["Failed"] );
				elseif group == THEME:GetString("Grade","NoneSectionText") then self:diffuse( Colors.Grade["None"] );
				end;
			else
				if sctext == "BeginnerMeter" then self:diffuse( Colors.Difficulty["Beginner"] );
				elseif sctext == "EasyMeter" then self:diffuse( Colors.Difficulty["Easy"] );
				elseif sctext == "MediumMeter" then self:diffuse( Colors.Difficulty["Medium"] );
				elseif sctext == "HardMeter" then self:diffuse( Colors.Difficulty["Hard"] );
				elseif sctext == "ChallengeMeter" then self:diffuse( Colors.Difficulty["Challenge"] );
				else self:diffuse(color("1,1,1,1"));
				end;
			end;
			self:Load( getenv("GroupImage") );
			self:zoomtowidth(160);
			self:zoomtoheight(getenv("GroupImageSize"));
			self:rate(getenv("GroupImageRate"));
		end;
	};

	Def.Quad {
		InitCommand=cmd(y,-70;zoomtowidth,160;zoomtoheight,20;diffuse,color("0,0,0,0.7"););
	};
	
	LoadActor(THEME:GetPathG("","bannercover1"))..{
		InitCommand=cmd(vertalign,bottom;y,SCREEN_CENTER_Y-220;zoomtowidth,160;zoomtoheight,40;diffusealpha,0.8;blend,'BlendMode_Add';);
	};

	Def.ActorFrame{
		Def.Quad{
			InitCommand=cmd(y,100;diffuse,color("1,1,0,0");diffusetopedge,color("1,1,0,0.1");
						diffusebottomedge,color("1,1,0,0");zoomtowidth,160;zoomtoheight,160/4;);
		};

		Def.Quad{
			InitCommand=cmd(diffuse,color("1,1,0,0");diffusetopedge,color("1,1,0,0.2");
						diffusebottomedge,color("1,1,0,0");zoomtowidth,160;zoomtoheight,160;);
		};
	};

	Def.ActorFrame{
		InitCommand=cmd(x,-46;y,-84;);
		SetMessageCommand=function(self, params)
			local group = params.Text;
			if group and GAMESTATE:GetSortOrder() == 'SortOrder_Group' then
				if group ~= "" and group ~= "N/A" then
					self:diffuse( SONGMAN:GetSongGroupColor(group) );
				else
					self:diffuse( color("1,1,1,0.8") );
				end;
			elseif group and
				(GAMESTATE:GetSortOrder() == 'SortOrder_Title' or GAMESTATE:GetSortOrder() == 'SortOrder_Artist') then
				if group == '0-9' then
					self:diffuse(HSVA( (360/28)*1,1,1,0.8 ));
				else
					self:diffuse(HSVA( (360/28)*titletable[group],1,1,0.8 ));
				end;
			elseif sctext == "TopGrades" then
				if group == THEME:GetString("Grade","Tier01") then self:diffuse( Colors.Grade["Tier01"] );
				elseif group == THEME:GetString("Grade","Tier02") then self:diffuse( Colors.Grade["Tier02"] );
				elseif group == THEME:GetString("Grade","Tier03") then self:diffuse( Colors.Grade["Tier03"] );
				elseif group == THEME:GetString("Grade","Tier04") then self:diffuse( Colors.Grade["Tier04"] );
				elseif group == THEME:GetString("Grade","Tier05") then self:diffuse( Colors.Grade["Tier05"] );
				elseif group == THEME:GetString("Grade","Tier06") then self:diffuse( Colors.Grade["Tier06"] );
				elseif group == THEME:GetString("Grade","Tier07") then self:diffuse( Colors.Grade["Tier07"] );
				elseif group == THEME:GetString("Grade","Failed") then self:diffuse( Colors.Grade["Failed"] );
				elseif group == THEME:GetString("Grade","NoneSectionText") then self:diffuse( Colors.Grade["None"] );
				end;
			else
				if sctext == "BeginnerMeter" then self:diffuse( Colors.Difficulty["Beginner"] );
				elseif sctext == "EasyMeter" then self:diffuse( Colors.Difficulty["Easy"] );
				elseif sctext == "MediumMeter" then self:diffuse( Colors.Difficulty["Medium"] );
				elseif sctext == "HardMeter" then self:diffuse( Colors.Difficulty["Hard"] );
				elseif sctext == "ChallengeMeter" then self:diffuse( Colors.Difficulty["Challenge"] );
				else self:diffuse( color("1,1,1,0.8") );
				end;
			end;
		end;
		
		LoadActor(THEME:GetPathG("_MusicWheelItem","parts/down_folder"))..{
			SetMessageCommand=function(self, params)
				local group = params.Text;
				self:blend('BlendMode_Add');	
				if group and GAMESTATE:GetSortOrder() == 'SortOrder_Group' then
					if group ~= "" and group ~= "N/A" then
						self:glow( SONGMAN:GetSongGroupColor(group) );
					end;
				elseif group and GAMESTATE:GetSortOrder() == 'SortOrder_Title' then
					if group == '0-9' then
						self:glow(HSVA( (360/28)*1,1,1,0.8 ));
					else
						self:glow(HSVA( (360/28)*titletable[group],1,1,0.8 ));
					end;
				elseif sctext == "TopGrades" then
					if group == THEME:GetString("Grade","Tier01") then self:glow( Colors.Grade["Tier01"] );
					elseif group == THEME:GetString("Grade","Tier02") then self:glow( Colors.Grade["Tier02"] );
					elseif group == THEME:GetString("Grade","Tier03") then self:glow( Colors.Grade["Tier03"] );
					elseif group == THEME:GetString("Grade","Tier04") then self:glow( Colors.Grade["Tier04"] );
					elseif group == THEME:GetString("Grade","Tier05") then self:glow( Colors.Grade["Tier05"] );
					elseif group == THEME:GetString("Grade","Tier06") then self:glow( Colors.Grade["Tier06"] );
					elseif group == THEME:GetString("Grade","Tier07") then self:glow( Colors.Grade["Tier07"] );
					elseif group == THEME:GetString("Grade","Failed") then self:glow( Colors.Grade["Failed"] );
					elseif group == THEME:GetString("Grade","NoneSectionText") then self:glow( Colors.Grade["None"] );
					end;
				else
					if sctext == "BeginnerMeter" then self:glow( Colors.Difficulty["Beginner"] );
					elseif sctext == "EasyMeter" then self:glow( Colors.Difficulty["Easy"] );
					elseif sctext == "MediumMeter" then self:glow( Colors.Difficulty["Medium"] );
					elseif sctext == "HardMeter" then self:glow( Colors.Difficulty["Hard"] );
					elseif sctext == "ChallengeMeter" then self:glow( Colors.Difficulty["Challenge"] );
					else self:glow( color("1,1,1,0.8") );
					end;
				end;
				self:diffusetopedge(color("1,1,1,0"));
				self:diffusebottomedge(color("1,1,1,0"));
			end;
		};
		
		LoadActor(THEME:GetPathG("_MusicWheelItem","parts/up_folder"))..{
		};
	};
	
	LoadFont("_shared2")..{
		InitCommand=cmd(shadowlength,0;zoom,0.55;horizalign,right;maxwidth,240;x,72;y,-50;diffuse,color("1,0.5,0,1"););
		SetMessageCommand=function(self)
			self:settext("MUSIC NUMBER");
		end;
	};
	
	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/expand_label"))..{
		InitCommand=cmd(shadowlength,0;x,-24;y,-68;diffuse,color("1,1,0,0.4"););
	};

	Def.Quad {
		InitCommand=cmd(y,66;zoomtowidth,160;zoomtoheight,80;diffuse,color("0,0,0,0.7");diffusebottomedge,color("0,0,0,0"));
		SetMessageCommand=function(self,params)
			local group = params.Text;
			self:visible(false);
			if getenv("GroupImage") == cjacket then
				if group and GAMESTATE:GetSortOrder() == 'SortOrder_Group' then
					if group ~= "" and group ~= "N/A" then
						if params.HasFocus then
							self:visible(false);
						else
							self:visible(true);
						end;
					end;
				elseif GAMESTATE:GetSortOrder() ~= 'SortOrder_Group' then
					if params.HasFocus then
						self:visible(false);
					else
						self:visible(true);
					end;
				end;
			end;
		end;
	};
	
	LoadFont("_shared2")..{
		InitCommand=cmd(zoomy,0.9;maxwidth,146;shadowlength,0);
		SetMessageCommand=function(self,params)
			local group = params.Text;
			local grouppath = SONGMAN:GetSongGroupBannerPath(group);
			self:visible(false);
			self:y(48);
			if group and GAMESTATE:GetSortOrder() == 'SortOrder_Group' then
				if group ~= "" and group ~= "N/A" then
					if params.HasFocus then
						self:visible(false);
					else
						if grouppath == "" then
							self:visible(true);
							self:diffuse( SONGMAN:GetSongGroupColor(group) );
							self:settextf("%s",params.Text);
						end;
					end;
				end;
			elseif GAMESTATE:GetSortOrder() ~= 'SortOrder_Group' then
				if params.HasFocus then
					self:visible(false);
					self:diffusealpha(0);
				else
					self:visible(true);
					self:diffusealpha(1);
					self:diffuse(color("0.5,1,0.1,1"));
					self:settextf("%s",params.Text);
				end;
			else
				self:visible(false);
				self:diffusealpha(0);
			end;
		end;
	};
};

return t;