
local t = Def.ActorFrame{};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local st = GAMESTATE:GetCurrentStyle():GetStepsType();
	local SongOrCourse, StepsOrTrail;
	if GAMESTATE:IsCourseMode() then
		SongOrCourse = GAMESTATE:GetCurrentCourse();
		StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
	else
		SongOrCourse = GAMESTATE:GetCurrentSong();
		StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
	end;
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:y(SCREEN_TOP+60);
			if pn == PLAYER_1 then
				self:horizalign(left);
				self:x(SCREEN_LEFT+60);
			else
				self:horizalign(right);
				self:x(SCREEN_RIGHT-60);
			end;
		end;
		LoadActor("diffback")..{
			InitCommand=function(self)
				if pn == PLAYER_1 then
					self:x(28);
				else
					self:x(-28);	
					self:rotationy(180);
				end;
			end;
			OnCommand=cmd(croptop,1;sleep,0.45;linear,0.2;croptop,0;sleep,2.75;linear,0.2;croptop,1;);
		};
		LoadActor( THEME:GetPathG("DiffDisplay","frame/frame") )..{
			InitCommand=cmd(animate,false;playcommand,"Update");
			OnCommand=function(self)
				local difficultyStates = {
					Difficulty_Beginner	= 0,
					Difficulty_Easy		= 2,
					Difficulty_Medium	= 4,
					Difficulty_Hard		= 6,
					Difficulty_Challenge	= 8,
					Difficulty_Edit		= 10,
				};
				if StepsOrTrail then
					local state = difficultyStates[StepsOrTrail:GetDifficulty()];
					if pn == PLAYER_2 then state = state + 1; end;
					self:setstate(state);
				end;
				(cmd(zoomtowidth,SCREEN_WIDTH*8;sleep,0.5;accelerate,0.15;zoomx,1;sleep,2.75;linear,0.2;cropbottom,1;))(self)
			end;
		};
		LoadFont("StepsDisplay meter")..{
			InitCommand=function(self)
				self:y(-4);
				if pn == PLAYER_1 then self:x(68);
				else self:x(-68);
				end;
				(cmd(maxwidth,60;zoom,0.8;skewx,-0.175))(self)
			end;
			OnCommand=function(self)
				if not GAMESTATE:IsCourseMode() then
					self:stoptweening();
					if SongOrCourse then
						if SongOrCourse:HasStepsTypeAndDifficulty(st,StepsOrTrail:GetDifficulty()) then
							local meter = StepsOrTrail:GetMeter();
							if GetAdhocPref("UserMeterType") == "CSStyle" and StepsOrTrail:GetDifficulty() ~= "Difficulty_Edit" then
								meter = GetConvertDifficulty(SongOrCourse,StepsOrTrail:GetDifficulty());
							end;
							self:settextf("%d",meter);
							self:diffuse(CustomDifficultyToColor(StepsOrTrail:GetDifficulty()));
						end;
					end;
				else
					self:settext("");
				end;
				
				local xmove = -10;
				if pn == PLAYER_2 then xmove = 10;
				end;
				(cmd(diffusealpha,0;sleep,0.65;diffusealpha,1;sleep,2.75;linear,0.2;addx,xmove;diffusealpha,0;))(self)
			end;
		};
	};
end;

return t;