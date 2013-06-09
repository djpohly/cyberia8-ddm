-- pick the right player or DIE!!
local Player = ...;
assert(Player);

local difficultyFrames = {
	Difficulty_Beginner	= 0,
	Difficulty_Easy		= 1,
	Difficulty_Medium		= 2,
	Difficulty_Hard		= 3,
	Difficulty_Challenge	= 4,
	Difficulty_Edit		= 5,
};
local coursemode = GAMESTATE:IsCourseMode();

local t = Def.ActorFrame{};

if coursemode then
	t[#t+1] = Def.ActorFrame{
		BeginCommand=cmd(player,Player);
		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == Player then
				self:visible(true);
			end;
		end;
		PlayerUnjoinedMessageCommand=function(self,param)
			if param.Player == Player then
				self:visible(false);
			end;
		end;
		Def.ActorFrame {
			InitCommand=cmd(x,2;y,14;player,PLAYER_1);
			LoadActor(THEME:GetPathG("_StepsDisplayListRow cursor", "p1"))..{
				CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"PositionCheck");
				CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"PositionCheck");
				PositionCheckCommand=function(self, params)
					if GAMESTATE:GetNumPlayersEnabled() > 1 then
						self:y(10);
					end;
				end;
			};
		};
		Def.ActorFrame {
			InitCommand=cmd(x,4;y,7;player,PLAYER_2);
			LoadActor(THEME:GetPathG("_StepsDisplayListRow cursor", "p2"))..{
			};
		};
		Def.ActorFrame {
			InitCommand=function(self)
				self:SetPlayer( Player );
				if GAMESTATE:GetNumPlayersEnabled() > 1 then
					if Player == PLAYER_1 then self:visible(false);
					else self:visible(true);
					end;
				else
					self:visible(GAMESTATE:IsHumanPlayer(Player));
				end;
			end;
			Def.DifficultyIcon {
				File="_difftable";
				InitCommand=cmd(rotationz,-90;);
				SetCommand=function(self, params)
					local SongOrCourse = nil;
					local StepsOrTrail = nil;
					if coursemode then
						SongOrCourse = GAMESTATE:GetCurrentCourse();
						StepsOrTrail = GAMESTATE:GetCurrentTrail(Player);
					end;
					if SongOrCourse and StepsOrTrail then
						local dc = StepsOrTrail:GetDifficulty()
						self:SetFromDifficulty( dc );
					else
						self:Unset();
					end;
				end;
				CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
				CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
				CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
			};
			LoadActor( THEME:GetPathG("StepsDisplay","autogen") )..{
				InitCommand=cmd(x,-260;y,-30;);
				OnCommand=cmd(zoomy,0;sleep,0.2;linear,0.2;zoomy,1;);
				SetCommand=function(self, params)
					local SongOrCourse = nil;
					if coursemode then
						SongOrCourse = GAMESTATE:GetCurrentCourse();
					end;
					if SongOrCourse:IsAutogen() then
						self:visible(true);
						self:finishtweening();
						(cmd(glowshift;effectcolor1,color("0.7,1,0,0.5");effectcolor2,color("1,1,1,0");effectperiod,1))(self);
					else
						self:visible(false);
						self:finishtweening();
					end;
				end;
				CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
			};
		};
	};
end;

return t;