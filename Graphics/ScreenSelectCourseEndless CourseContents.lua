local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
--[[
	Def.Quad{
		Name="TopMask";
		InitCommand=cmd(x,0;y,-164;zoomto,280,160;valign,1;clearzbuffer,true;zwrite,true;blend,Blend.NoEffect;);
	};
]]
	Def.Quad{
		Name="BottomMask";
		InitCommand=cmd(x,-4;y,164;zoomto,290,160;valign,0;clearzbuffer,false;zwrite,true;blend,Blend.NoEffect;);
	};

	Def.CourseContentsList {
		--CourseContents Main
		MaxSongs = 4;
		NumItemsToDraw = 4;
		OnCommand=function(self)
			local coursestages = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages();
			self:finishtweening();
			self:clearzbuffer(true);
			self:zwrite(true);
			self:zbuffer(true);
			self:ztest(true);
			self:z(0);
			self:SetDestinationItem(0);
			self:SetCurrentAndDestinationItem(2);
			self:SetFromGameState();
			self:setsize(260,82*coursestages);
			self:PositionItems();
			self:SetTransformFromHeight(82);
			self:SetLoop(false);
			self:setsecondsperitem(0);
			self:stoptweening();
		end;
		CurrentCourseChangedMessageCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			self:visible( course and true or false );
			self:playcommand("On");
		end;
		CurrentTrailP1ChangedMessageCommand=function(self)
			self:finishtweening();
			self:SetDestinationItem(0);
			self:SetCurrentAndDestinationItem(2);
			self:PositionItems();
			self:playcommand("On");
		end;
		CurrentTrailP2ChangedMessageCommand=function(self)
			self:finishtweening();
			self:SetDestinationItem(0);
			self:SetCurrentAndDestinationItem(2);
			self:PositionItems();
			self:playcommand("On");
		end;

		--Parts
		Display = Def.ActorFrame {
			InitCommand=cmd(setsize,270,82;);

			Def.Quad {
				InitCommand=cmd(x,-46;y,42;zoomto,200,81;diffuse,color("0,0,0,1");diffuseleftedge,color("0,0,0,0");diffusebottomedge,color("0,0,0,0.7"););
				OnCommand=cmd(finishtweening;cropleft,1;linear,0.3;cropleft,0;);
			};

			Def.Banner {
				OnCommand=cmd(diffusealpha,0;x,-10;y,41;accelerate,0.3;diffusealpha,1;x,0;);
				SetSongCommand=function(self, params)
					local showjacket = GetAdhocPref("ShowJackets");
					local path = THEME:GetPathG("Common","fallback banner");
					local zoom = 25;
					if showjacket == "On" then
						path = THEME:GetPathG("Common","fallback jacket");
						zoom = 80;
					end;
					self:Load(path);
					self:zoomtowidth(80);
					self:zoomtoheight(zoom);
				end;
			};
			Def.ActorFrame {
				OnCommand=cmd(zoomx,0;sleep,0.1;linear,0.2;zoomx,1;);
				Def.TextBanner {
					InitCommand=cmd(x,22;y,68;Load,"CourseTextBanner";SetFromString,"", "", "", "", "", "");
					SetSongCommand=function(self, params)
						(cmd(zoom,0.75))(self);
						self:SetFromString( "??????????", "??????????", "", "", "", "" );
						self:diffuse( color("#FFFFFF") );
					end;
				};
			};

			LoadFont("CourseEntryDisplay","number") .. {
				InitCommand=cmd(x,-134;y,20;horizalign,left;skewx,-0.125;shadowlength,2;zoom,1.25;maxwidth,30;diffuse,color("1,1,0,1"););
				OnCommand=cmd(diffusealpha,0;addy,-10;accelerate,0.3;diffusealpha,1;addy,10;);
				SetSongCommand=function(self, params)
					self:visible(true);
					local numStages = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages()
					if params.Number <= numStages then
						self:settext(string.format("%i", params.Number)); 
					end;
				end;
			};

			-- replacement for foot
			LoadActor( THEME:GetPathG("DifficultyDisplay","Bar") )..{
				InitCommand=cmd(x,-72;y,40;zoom,0.75;shadowlength,2;horizalign,right;animate,false);
				OnCommand=cmd(diffusealpha,0;addx,10;accelerate,0.3;diffusealpha,1;addx,-10;);
				SetSongCommand=function(self, params)
					local difficultyToFrame = {
						Difficulty_Beginner = 0,
						Difficulty_Easy = 1,
						Difficulty_Medium = 2,
						Difficulty_Hard = 3,
						Difficulty_Challenge = 4,
						Difficulty_Edit = 5,
					};
					if params.Difficulty then
						self:setstate(difficultyToFrame[params.Difficulty]);
					end;
				end;
			};
			LoadFont("CourseEntryDisplay","difficulty") .. {
				Text="0";
				InitCommand=cmd(x,-68;y,38;shadowlength,2;zoom,1;horizalign,left;skewx,-0.125;maxwidth,26);
				OnCommand=cmd(diffusealpha,0;addy,10;accelerate,0.3;diffusealpha,1;addy,-10;);
				SetSongCommand=function(self, params)
					if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
					self:settext( params.Meter );
					if params.Difficulty then
						self:diffuse( CustomDifficultyToColor(params.Difficulty) );
					end;
				end;
			};
			LoadActor( THEME:GetPathB("","arrow") )..{
				SetSongCommand=function(self, params)
					local coursestages = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages();
					if params.Number >= 1 and params.Number < coursestages then self:visible(true);
					else self:visible(false);
					end;
				end;
				OnCommand=cmd(x,-120;y,80;rotationz,90;diffusealpha,0;sleep,0.5;queuecommand,"Repeat";);
				ScrollDownCommand=cmd(queuecommand,"Repeat";);
				StopCommand=cmd(queuecommand,"Repeat";);
				ScrollUpCommand=cmd(queuecommand,"Repeat";);
				RepeatCommand=cmd(addy,-12;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,1;glow,color("0,0,0,0");addy,12;diffusealpha,0;queuecommand,"Repeat";);
			};
		};
	};
};
return t;