local bUse3dModels = GetAdhocPref("Enable3DModels");

return Def.Model{
		Meshes=THEME:GetPathB("_shared","models/_04_nline/04_nline_mesh.txt"),
		Materials=THEME:GetPathB("_shared","models/_04_nline/04_nline_materials.txt"),
		Bones=THEME:GetPathB("_shared","models/_04_nline/04_nline_bones.txt"),
		InitCommand=function(self)
			if bUse3dModels == 'On' then
				self:visible(true);
			else
				self:visible(false);
			end;
		end;
};