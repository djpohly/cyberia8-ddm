
local st = GAMESTATE:GetCurrentStyle():GetStepsType();

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
		MaxSongs = 10;
		NumItemsToDraw = 4;
		OnCommand=function(self)
			local coursestages = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages();
			self:finishtweening();
			--self:clearzbuffer(true);
			--self:zwrite(true);
			--self:zbuffer(true);
			--self:ztest(true);
			--self:z(0);
			self:SetDestinationItem(0);
			self:SetCurrentAndDestinationItem(2);
			self:SetFromGameState();
			self:setsize(260,82*coursestages);
			self:PositionItems();
			self:SetTransformFromHeight(82);
			self:SetLoop(false);
		
			if GAMESTATE:GetPlayMode() == 'PlayMode_Endless' then
				self:setsecondsperitem(0);
				self:stoptweening();
			elseif coursestages < 5 or coursestages == nil then
				self:setsecondsperitem(0);
				self:stoptweening();
			else
				self:sleep(2);
				self:queuecommand("ScrollDown");
			end;
		end;
		ScrollDownCommand = function(self)
			local coursestages = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages();
			self:finishtweening();
			self:setsecondsperitem(1);
			self:SetDestinationItem(self:GetNumItems());
			--[ja] SetSecondsPauseBetweenItemsを使うとスクローラーの挙動が…なのでここで対策
			local fTime = self:GetSecondsToDestination();
			if coursestages >= 10 then self:sleep(fTime+4);
			elseif coursestages == 9 then self:sleep(fTime+3);
			elseif coursestages == 8 then self:sleep(fTime+2);
			elseif coursestages == 7 then self:sleep(fTime+1);
			elseif coursestages == 6 then self:sleep(fTime);
			else self:sleep(fTime-1);
			end;
			self:SetSecondsPauseBetweenItems(1);
			self:queuecommand("ScrollUp");
		end;
		ScrollUpCommand = function(self)
			self:finishtweening();
			self:setsecondsperitem(0.0001);
			self:SetDestinationItem(0);
			self:SetCurrentAndDestinationItem(2);
			self:sleep(3);
			self:queuecommand("ScrollDown");
		end;
		CurrentCourseChangedMessageCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			self:visible( course and true or false );
			self:playcommand("On");
		end;
		CurrentTrailP1ChangedMessageCommand=function(self)
			self:finishtweening();
			self:SetCurrentAndDestinationItem(2);
			self:PositionItems();
			self:playcommand("On");
		end;
		CurrentTrailP2ChangedMessageCommand=function(self)
			self:finishtweening();
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

			--[ja] Spriteのほうが軽い(っぽい)。ユーザーにダイアログのチェックの協力を
			--Def.Banner {
			Def.Sprite {
				OnCommand=cmd(diffusealpha,0;x,-10;y,41;accelerate,0.3;diffusealpha,1;x,0;);
				SetSongCommand=function(self, params)
					if GAMESTATE:GetPlayMode() ~= 'PlayMode_Endless' then
						--self:diffusebottomedge(color("0.6,0.6,0.6,1"));
						--self:diffuseleftedge(color("1,1,1,0.8"));
						local song = params.Song;
						local showbanner = PREFSMAN:GetPreference('ShowBanners');
						local showjacket = GetAdhocPref("ShowJackets");
						local path = THEME:GetPathG("Common","fallback jacket");
						local zoom = 80;
						if song then
							local jacketpath = song:GetJacketPath();
							local sbannerpath = song:GetBannerPath();
							local cdimagepath = song:GetCDImagePath();
							local sbackgroundpath = song:GetBackgroundPath();
							if showbanner then
								if showjacket == "On" then
									if jacketpath then 
										path = jacketpath;
									elseif sbannerpath then
										path = sbannerpath;
										zoom = 25;
									elseif cdimagepath then
										path = cdimagepath;
									elseif sbackgroundpath then
										path = sbackgroundpath;
									end;
								else
									if sbannerpath then
										path = sbannerpath;
										zoom = 25;
									end;
								end;
							else
								path = THEME:GetPathG("Common","fallback banner");
								zoom = 25;
							end;
						end;
						self:Load(path);
						self:zoomtowidth(80);
						self:zoomtoheight(zoom);
					end;
				end;
			};
			Def.ActorFrame {
				OnCommand=cmd(zoomx,0;sleep,0.1;linear,0.2;zoomx,1;);
				Def.TextBanner {
					InitCommand=cmd(x,22;y,68;Load,"CourseTextBanner";SetFromString,"", "", "", "", "", "");
					SetSongCommand=function(self, params)
						if GAMESTATE:GetPlayMode() == 'PlayMode_Endless' then
							self:SetFromString( "??????????", "??????????", "", "", "", "" );
							self:diffuse( color("#FFFFFF") );
						elseif params.Song then
							self:SetFromSong( params.Song );
							self:diffuse( SONGMAN:GetSongColor(params.Song) );
						else
							self:SetFromString( "??????????", "??????????", "", "", "", "" );
							self:diffuse( color("#FFFFFF") );
						end
						(cmd(zoom,0.75))(self);
					end;
				};
			};

			LoadFont("CourseEntryDisplay","number") .. {
				InitCommand=cmd(x,-134;y,20;horizalign,left;skewx,-0.125;shadowlength,2;zoom,1.25;maxwidth,30;diffuse,color("1,1,0,1"););
				OnCommand=cmd(diffusealpha,0;addy,-10;accelerate,0.3;diffusealpha,1;addy,10;);
				SetSongCommand=function(self, params)
					self:visible(true);
					local numStages = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages();
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
				InitCommand=cmd(x,-68;y,38;shadowlength,2;zoom,1;horizalign,left;skewx,-0.125;maxwidth,26);
				OnCommand=cmd(diffusealpha,0;addy,10;accelerate,0.3;diffusealpha,1;addy,-10;);
				SetSongCommand=function(self, params)
					if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
					local song = params.Song;
					local cdiff = params.Difficulty;
					if song:HasStepsTypeAndDifficulty(st,cdiff) then
						local meter = 0;
						if GetAdhocPref("UserMeterType") == "CSStyle" then
							meter = GetConvertDifficulty(song,cdiff);
						else
							meter = params.Meter
						end;
						self:settextf("%d",meter);
						self:diffuse(CustomDifficultyToColor(cdiff));
					end;
				end;
			};
			LoadActor( THEME:GetPathG("StepsDisplay","autogen") )..{
				InitCommand=cmd(x,-70;y,52;zoom,0.85;shadowlength,2;);
				OnCommand=cmd(zoomy,0;sleep,0.2;linear,0.2;zoomy,0.85;);
				SetSongCommand=function(self, params)
					if params.Steps:IsAutogen() then
						self:visible(true);
						self:finishtweening();
						(cmd(glowshift;effectcolor1,color("0.7,1,0,0.5");effectcolor2,color("1,1,1,0");effectperiod,1))(self);
					else
						self:visible(false);
						self:finishtweening();
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
				ScrollUpCommand=cmd(queuecommand,"Repeat";);
				RepeatCommand=cmd(addy,-12;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,1;glow,color("0,0,0,0");addy,12;diffusealpha,0;queuecommand,"Repeat";);
			};
		};
	};
};
return t;