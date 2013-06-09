function PlayerColor( pn )
	if pn == PLAYER_1 then return color("0,1,0.7,1") end
	if pn == PLAYER_2 then return color("0,0.7,1,1") end
	return color("1,1,1,1")
end

Colors = {
	Difficulty = {
		Beginner	= color("0,0.9,1"),
		Easy		= color("1,0.7,0.2"),
		Medium	= color("1,0.4,0.5"),
		Hard		= color("0.2,1,0.2"),
		Challenge	= color("0.5,0.4,1"),
		Edit		= color("0.8,0.8,0.8"),
		Difficulty_Beginner	= color("0,0.9,1"),
		Difficulty_Easy		= color("1,0.7,0.2"),
		Difficulty_Medium		= color("1,0.4,0.5"),
		Difficulty_Hard		= color("0.2,1,0.2"),
		Difficulty_Challenge	= color("0.5,0.4,1"),
		Difficulty_Edit		= color("0.8,0.8,0.8"),

		Couple		= color("#ed0972"),
		Routine		= color("#ff9a00"),
		Difficulty_Couple	= color("#ed0972"),
		Difficulty_Routine	= color("#ff9a00"),
	};
	Course = {
		Beginner	= color("0,0.9,1"),
		Easy		= color("1,0.7,0.2"),
		Medium	= color("1,0.4,0.5"),
		Hard		= color("0.2,1,0.2"),
		Challenge	= color("0.5,0.4,1"),
		Difficulty_Beginner	= color("0,0.9,1"),
		Difficulty_Easy		= color("1,0.7,0.2"),
		Difficulty_Medium		= color("1,0.4,0.5"),
		Difficulty_Hard		= color("0.2,1,0.2"),
		Difficulty_Challenge	= color("0.5,0.4,1"),

		Edit		= color("0.8,0.8,0.8"),
		Couple	= color("#ed0972"),
		Routine	= color("#ff9a00"),
	};
	Judgment = {
		JudgmentLine_W1		= color("1,1,1"),
		JudgmentLine_W2		= color("1,0.8,0.2"),
		JudgmentLine_W3		= color("0,1,0.2"),
		JudgmentLine_W4		= color("#34bfff"),
		JudgmentLine_W5		= color("#e44dff"),
		JudgmentLine_Held		= color("1,1,0.4"),
		JudgmentLine_Miss		= color("#ff3c3c"),
		JudgmentLine_LetGo		= color("#ff3c3c"),
		JudgmentLine_MaxCombo	= color("#ffc600")
	};
	Count = {
		Plus		= color("0.5,0.3,1"),
		Minus	= color("1,0.3,0.5"),
	};
	Grade = {
		Tier01		= color("1,1,1"),
		Tier02		= color("0,1,1"),
		Tier03		= color("#32D0CC"),
		Tier04		= color("#087A73"),
		Tier05		= color("#72BEF1"),
		Tier06		= color("#2D9CF4"),
		Tier07		= color("#B871A2"),
		Failed		= color("#AA0004"),
		None			= color("0.5,0.5,0.5")
	};
};

function CustomDifficultyToColor( sCustomDifficulty ) 
	return Colors.Difficulty[sCustomDifficulty]
end

function CustomDifficultyToLightColor( sCustomDifficulty ) 
	local c = Colors.Difficulty[sCustomDifficulty]
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

function CustomDifficultyToLightColor( sCustomDifficulty ) 
	local c = Colors.Difficulty[sCustomDifficulty]
	return { scale(c[1],0,1,0.5,1), scale(c[2],0,1,0.5,1), scale(c[3],0,1,0.5,1), c[4] }
end

function GetSortColor(sortmenu)
	if sortmenu then
		local beginner = THEME:GetString("MusicWheel","BeginnerMeterText");
		local easy = THEME:GetString("MusicWheel","EasyMeterText");
		local medium = THEME:GetString("MusicWheel","MediumMeterText");
		local hard = THEME:GetString("MusicWheel","HardMeterText");
		local challenge = THEME:GetString("MusicWheel","ChallengeMeterText");
		local group = THEME:GetString("MusicWheel","GroupText");
		if sortmenu == beginner then return Colors.Difficulty["Beginner"]
		elseif sortmenu == easy then return Colors.Difficulty["Easy"]
		elseif sortmenu == medium then return Colors.Difficulty["Medium"]
		elseif sortmenu == hard then return Colors.Difficulty["Hard"]
		elseif sortmenu == challenge then return Colors.Difficulty["Challenge"]
		elseif sortmenu == group then return color("0.5,1,0,1")
		else return THEME:GetMetric("MusicWheel","SortMenuColor")
		end
	end
	return THEME:GetMetric("MusicWheel","SortMenuColor")
end