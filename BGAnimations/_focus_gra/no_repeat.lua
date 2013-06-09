--[[_focus_gra]]

local t = Def.ActorFrame{};
	for i = 1, 9 do
		local function sleepwait()
			local wait = 0.075 * i;
			return wait
		end;
		local function xset()
			local x = 0
			if i == 1 or i == 2 then
				x = 80
			elseif i == 3 or i == 6 or i == 7 then
				x = -80
			elseif i == 4 or i == 9 then
				x = 160
			elseif i == 5 then
				x = -160
			end;
			return x
		end;
		local function yset()
			local y = 0
			if i == 1 or i == 5 then
				y = -80
			elseif i == 4 or i == 6 then
				y = -160
			elseif i == 3 or i == 8 then
				y = -240
			end;
			return y
		end;
		local function basecolor()
			local bcolor = "1,1,0,1";
			if GAMESTATE:IsExtraStage() then
				if i == 2 or i == 6 then
					bcolor = "1,0.25,0,1";
				else
					bcolor = "1,0,0,1";
				end;
			else
				if i == 2 or i == 6 then
					bcolor = "1,0.3,0,1";
				else
					bcolor = "1,1,0,1";
				end;
			end;
			return bcolor
		end;

		t[#t+1] = Def.ActorFrame{
			--InitCommand=cmd(x,xset();y,yset();rotationx,-45;rotationz,45;);
			LoadActor("_square_focus")..{
				InitCommand=cmd(blend,'BlendMode_Add';x,xset();y,yset(););
				OnCommand=cmd(stoptweening;diffuse,color(basecolor());diffusealpha,0;sleep,sleepwait();decelerate,0.3;diffusealpha,0.8;
							linear,1;diffusealpha,0;);
			};
		};
	end;
return t;
