
local t = Def.ActorFrame{
	LoadFont("","_shared2")..{
		InitCommand=cmd(horizalign,left;zoomy,0.9;y,6;maxwidth,225;shadowlength,0);
		OnCommand=function(self)
			self:stoptweening();
			if not GAMESTATE:IsCourseMode() then
				if getenv("SSort") == getenv("CSort") then
					local envsort = getenv("CSort");
					local sorttext = "";
					if envsort == THEME:GetString("ScreenSort","Group") then
						sorttext = "GROUP"
					elseif envsort == THEME:GetString("ScreenSort","Title") then
						sorttext = "TITLE"
					elseif envsort == THEME:GetString("ScreenSort","Artist") then
						sorttext = "ARTIST"
					elseif envsort == THEME:GetString("ScreenSort","Bpm") then
						sorttext = "BPM"
					elseif envsort == THEME:GetString("ScreenSort","Popularity") then
						sorttext = "BEST 50"
					elseif envsort == THEME:GetString("ScreenSort","BeginnerMeter") then
						sorttext = "BEGINNER METER"
					elseif envsort == THEME:GetString("ScreenSort","EasyMeter") then
						sorttext = "LIGHT METER"
					elseif envsort == THEME:GetString("ScreenSort","MediumMeter") then
						sorttext = "STANDARD METER"
					elseif envsort == THEME:GetString("ScreenSort","HardMeter") then
						sorttext = "HEAVY METER"
					elseif envsort == THEME:GetString("ScreenSort","ChallengeMeter") then
						sorttext = "CHALLENGE METER"
					elseif envsort == THEME:GetString("ScreenSort","Genre") then
						sorttext = "GENRE"
					elseif envsort == THEME:GetString("ScreenSort","TopGrades") then
						sorttext = "TOP GRADE(S)"
					elseif envsort == THEME:GetString("ScreenSort","Length") then
						sorttext = "SONG LENGTH"
					elseif envsort == THEME:GetString("ScreenSort","Recent") then
						sorttext = "RECENT"
					end;
					self:settext(sorttext);
					self:diffuse(GetSortColor(envsort));
					(cmd(finishtweening;x,116+9;linear,0.15;x,116+14;))(self);
				end;
			else
				self:settext("");
				return;
			end;
		end;
		OffCommand=cmd(stoptweening;);
	};
	
	LoadFont("","_shared2")..{
		InitCommand=cmd(horizalign,left;zoom,0.65;maxwidth,450;shadowlength,0);
		OnCommand=function(self)
			self:stoptweening();
			if not GAMESTATE:IsCourseMode() then
				if getenv("SSort") == getenv("CSort") then
					local envsort = getenv("CSort");
					local sortdes = "";
					if envsort == THEME:GetString("ScreenSort","Group") then
						sortdes = THEME:GetString("ScreenSort","GroupDes");
					elseif envsort == THEME:GetString("ScreenSort","Title") then
						sortdes = THEME:GetString("ScreenSort","TitleDes");
					elseif envsort == THEME:GetString("ScreenSort","Artist") then
						sortdes = THEME:GetString("ScreenSort","ArtistDes");
					elseif envsort == THEME:GetString("ScreenSort","Bpm") then
						sortdes = THEME:GetString("ScreenSort","BpmDes");
					elseif envsort == THEME:GetString("ScreenSort","Popularity") then
						sortdes =THEME:GetString("ScreenSort","PopularityDes");
					elseif envsort == THEME:GetString("ScreenSort","BeginnerMeter") then
						sortdes = THEME:GetString("ScreenSort","MeterDes");
					elseif envsort == THEME:GetString("ScreenSort","EasyMeter") then
						sortdes = THEME:GetString("ScreenSort","MeterDes");
					elseif envsort == THEME:GetString("ScreenSort","MediumMeter") then
						sortdes = THEME:GetString("ScreenSort","MeterDes");
					elseif envsort == THEME:GetString("ScreenSort","HardMeter") then
						sortdes = THEME:GetString("ScreenSort","MeterDes");
					elseif envsort == THEME:GetString("ScreenSort","ChallengeMeter") then
						sortdes = THEME:GetString("ScreenSort","MeterDes");
					elseif envsort == THEME:GetString("ScreenSort","Genre") then
						sortdes = THEME:GetString("ScreenSort","GenreDes");
					elseif envsort == THEME:GetString("ScreenSort","TopGrades") then
						sortdes = THEME:GetString("ScreenSort","TopGradesDes");
					elseif envsort == THEME:GetString("ScreenSort","Length") then
						sortdes = THEME:GetString("ScreenSort","LengthDes");
					elseif envsort == THEME:GetString("ScreenSort","Recent") then
						sortdes = THEME:GetString("ScreenSort","RecentDes");
					end;
					self:settext(sortdes);
					self:diffuse(GetSortColor(envsort));
					(cmd(finishtweening;x,116+19;y,-10;linear,0.15;x,116+14;))(self);
				end;
			else
				self:settext("");
				return;
			end;
		end;
		OffCommand=cmd(stoptweening;);
	};
};

local function update(self)
	if getenv("SSort") ~= getenv("CSort") then
		setenv("CSort",getenv("SSort"));
		self:playcommand("On");
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,update;);

return t;