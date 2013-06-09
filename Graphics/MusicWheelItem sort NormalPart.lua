local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local pm = GAMESTATE:GetPlayMode();
local eset = false;
local st = GAMESTATE:GetCurrentStyle():GetStepsType();
--setenv("sortset","")
local oldSort = nil;
local ac = 1;
local limit = getenv("Timer");

local t = Def.ActorFrame{};

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
	Def.Sprite {
		Name="SongJacket";
		InitCommand=cmd(diffusealpha,1;y,100;rotationy,180;rotationz,180;);
		SetMessageCommand=function(self, params)
			self:diffusetopedge(color("0,0,0,0"));
			self:diffusebottomedge(color("1,1,1,0.7"));
			group = params.Text;
			if group then
				self:Load( THEME:GetPathG("_MusicWheelItem","parts/sortsection_jacket") );
				
				self:zoomtowidth(160);
				self:zoomtoheight(160/4);
			end;
		end;
	};
	
	Def.Sprite {
		Name="SongJacket";
		InitCommand=cmd(diffusealpha,1;);
		SetMessageCommand=function(self, params)
			group = params.Text;
			if group then
				self:Load( THEME:GetPathG("_MusicWheelItem","parts/sortsection_jacket") );
				self:zoomtowidth(160);
				self:zoomtoheight(160);
			end;
		end;
	};

	Def.Quad {
		InitCommand=cmd(y,-70;zoomtowidth,160;zoomtoheight,20;diffuse,color("0,0,0,0.9"););
	};

	LoadActor(THEME:GetPathG("","bannercover1"))..{
		InitCommand=cmd(vertalign,bottom;y,SCREEN_CENTER_Y-220;zoomtowidth,160;zoomtoheight,40;diffusealpha,0.8;blend,'BlendMode_Add';);
	};

	Def.ActorFrame{
		InitCommand=cmd(x,-46;y,-84;zoomy,0;sleep,0.05;accelerate,0.3;zoomy,1;);
		SetMessageCommand=function(self, params)
			local sortmenu = params.Label;
			if sortmenu then
				self:diffuse(color("0.5,1,0.1,0.8"));
			end;
		end;
		
		LoadActor(THEME:GetPathG("_MusicWheelItem","parts/down_folder"))..{
			SetMessageCommand=function(self, params)
				local sortmenu = params.Label;
				if sortmenu then
					self:diffusetopedge(color("0.5,1,0.1,0.8"));
					self:diffusebottomedge(color("0.5,1,0.1,0"));
				end;
			end;
		};

		LoadActor(THEME:GetPathG("_MusicWheelItem","parts/up_folder"))..{
		};
	};
	
	LoadFont("_shared2")..{
		InitCommand=cmd(zoom,0.65;maxwidth,225;x,-74;horizalign,left;shadowlength,0);
		SetMessageCommand=function(self,params)
			local sortmenu = params.Label;
			if sortmenu then
				self:visible(true);
				self:diffusealpha(1);
				self:settextf("%s",params.Label);
				self:diffuse(GetSortColor(sortmenu));
			else
				self:visible(false);
				self:diffusealpha(0);
			end;
		end;
		UpdateCommand=cmd(playcommand,"SetMessage";);
		CurrentSongChangedMessageCommand=cmd(playcommand,"SetMessage");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"SetMessage");
	};
	
	LoadActor(THEME:GetPathG("_MusicWheelItem","parts/sort_label"))..{
		InitCommand=cmd(shadowlength,0;x,-42;y,-68;diffuse,color("0.5,1,0.1,0.4"););
	};
};
	
--local sortst;
--sortst = Def.ActorFrame{

t[#t+1] = Def.ActorFrame{ 
	LoadFont("_shared2")..{
		InitCommand=cmd(zoomy,0.9;maxwidth,225;y,90;shadowlength,0);
		SetMessageCommand=function(self,params)
			local sortmenu = params.Label;
			self:visible(false);
			local sortm = GAMESTATE:GetSortOrder();
			if sortmenu and sortm == 'SortOrder_ModeMenu' then
				if params.HasFocus then
					self:visible(false);
					if sortmenu ~= "" and sortmenu ~= "N/A" then
						setenv("wheelsectionsort",params.Label);
					else
						setenv("wheelsectionsort","");
					end;
				else
				
				end;
			else
				self:visible(false);
			end;
		end;
		CodeMessageCommand=function(self,params)
			local musicwheel = SCREENMAN:GetTopScreen():GetMusicWheel();
			local song = GAMESTATE:GetCurrentSong();
			if not song then
				if limit > 2 then
					if musicwheel:GetSelectedType() == 'WheelItemDataType_Custom' then
						if params.Name == "Start" then
							setenv("csflag",1);
							--SCREENMAN:SetNewScreen("ScreenCSOpen");
							SCREENMAN:AddNewScreenToTop("ScreenMiniMenuCSC");
						end;
					end;
				end;
			end;
		end;
		UpdateCommand=cmd(playcommand,"SetMessage";);
		CurrentSongChangedMessageCommand=cmd(playcommand,"SetMessage");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"SetMessage");
	};
};


--[[
local function Update(self)
	local newSort = getenv("sortset");
	if newSort ~= oldSort then
		MESSAGEMAN:Broadcast("SetMessage", { Label = newSort });
	end;
	newSort = oldSort;
end;

sortst.InitCommand=cmd(SetUpdateFunction,Update)
t[#t+1] = sortst;

]]
	
return t;