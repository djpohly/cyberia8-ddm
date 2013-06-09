local t = LoadFallbackB();
local cst = GAMESTATE:GetCurrentStyle():GetStyleType();
local pm = GAMESTATE:GetPlayMode();

if not GAMESTATE:IsDemonstration() then

t[#t+1] = StandardDecorationFromFileOptional( "DiffDisplayP1","DiffDisplayP1" );
t[#t+1] = StandardDecorationFromFileOptional( "DiffDisplayP2","DiffDisplayP2" );
--[[ top of screen ]]
t[#t+1] = StandardDecorationFromFile( "LifeFrame", "LifeFrame" );
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay");
t[#t+1] = StandardDecorationFromFileOptional( "StageDisplay", "StageDisplay" );
--t[#t+1] = StandardDecorationFromFile( "SongTitle", "SongTitle" );
t[#t+1] = StandardDecorationFromFile( "BannerTitle", "BannerTitle" );

--[[ bottom of screen ]]
t[#t+1] = StandardDecorationFromFile( "ScoreFrame", "ScoreFrame" );
t[#t+1] = StandardDecorationFromFile( "SongPosition", "SongPosition" );

--[[
if ProductVersion() ~= "v5.0 alpha 3" and ProductVersion() ~= "v5.0 alpha 2" then
	if ( not GAMESTATE:IsCourseMode() ) then
		t[#t+1] = Def.Actor{
			JudgmentMessageCommand = function(self, params)
				Scoring[GetUserPref("UserPrefScoringMode")](params, 
					STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player))
			end;
		};
	end;
end;
]]

if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
--life
t[#t+1] = LoadActor("mclife",PLAYER_1)..{
	InitCommand=cmd(x,SCREEN_LEFT+23;y,SCREEN_TOP+34;draworder,93);
	OnCommand=cmd(zoomy,0;sleep,0.8;linear,0.2;zoomy,1);
};

t[#t+1] = LoadActor("mclife",PLAYER_2)..{
	InitCommand=cmd(x,SCREEN_RIGHT-23;y,SCREEN_TOP+34;draworder,93);
	OnCommand=cmd(zoomy,0;sleep,0.8;linear,0.2;zoomy,1);
};
end;

--demo
end;

return t;