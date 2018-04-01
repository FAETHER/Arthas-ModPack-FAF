--------------------------------------------------------------------------------
-- Wall scripts
--------------------------------------------------------------------------------
function CardinalWallUnit(SuperClass)
    return Class(SuperClass) {
        OnCreate = function(self)
            self.Info = {
                ents = {
                    ['North'] = {
                        ent = {},
                        val = {false, 99 },
                    },
                    ['South'] = {
                        ent = {},
                        val = {false, 101},
                    },
                    ['East'] = {
                        ent = {},
                        val = {false, 97},
                    },
                    ['West'] = {
                        ent = {},
                        val = {false, 103},
                    },
                },
                bones = {}
            }
            for i, v in self:GetBlueprint().Display.AdjacencyConnectionInfo.Bones do
                self.Info.bones[i] = {}
                for j, k in v do
                    self.Info.bones[i][j] = k                 
                end
            end
            
            self:BoneUpdate(self.Info.bones)
            SuperClass.OnCreate(self)
        end,
           
        OnStopBeingBuilt = function(self,builder,layer)
            SuperClass.OnStopBeingBuilt(self,builder,layer)
            --This is here purely for the UEF ones, because it doesn't work OnCreate for them.
            self:BoneUpdate(self.Info.bones)   
        end,
          
        OnAdjacentTo = function(self, adjacentUnit, triggerUnit)
            local dirs = { 'South', 'East', 'East', 'North', 'North', 'West', 'West', 'South'}
            local MyX, MyY, MyZ = unpack(self:GetPosition())
            local AX, AY, AZ = unpack(adjacentUnit:GetPosition())
            local cat = self:GetBlueprint().Display.AdjacencyConnection
            
            if EntityCategoryContains(categories[cat], adjacentUnit) then
                local dir = dirs[math.ceil(((math.atan2(MyX - AX, MyZ - AZ) * 180 / math.pi) + 180)/45)]
                self.Info.ents[dir].ent = adjacentUnit
                self.Info.ents[dir].val[1] = true
            end
                  
            self:BoneCalculation() 
            
            SuperClass.OnAdjacentTo(self, adjacentUnit, triggerUnit) 
        end,
    
        BoneCalculation = function(self)
            local TowerCalc = 0
            for i, v in self.Info.ents do
                if v.val[1] == true then
                    TowerCalc = TowerCalc + v.val[2]
                    self:SetAllBones('bonetype', i, 'show')
                    self:SetAllBones('conflict', i, 'hide')
                else
                    self:SetAllBones('bonetype', i, 'hide')
                end 
            end
            if TowerCalc == 200 then
                self:SetAllBones('bonetype', 'Tower', 'hide')
            else
                self:SetAllBones('bonetype', 'Tower', 'show')
                self:SetAllBones('conflict', 'Tower', 'hide')
            end
            if self:GetBlueprint().Display.AdjacencyBeamConnections then
                for k1, v1 in self.Info.ents do
                    if v1.val[1] then
                        for k, v in self.Info.bones do
                            if v.bonetype == 'Beam' then
                                if self:IsValidBone(k) and v1.ent:IsValidBone(k) then
                                    v1.ent.Trash:Add(AttachBeamEntityToEntity(self, k, v1.ent, k, self:GetArmy(), v.beamtype))
                                end
                            end
                        end
                    end
                end
            end
            self:BoneUpdate(self.Info.bones)  
        end,
    
        BoneUpdate = function(self, bones)
            for k, v in bones do
                if v.visibility == 'show' then   
                    if self:IsValidBone(k) then
                        self:ShowBone(k, true)
                    end
                else
                    if self:IsValidBone(k) then   
                        self:HideBone(k, true) 
                    end
                end
            end                                               
        end,  
        
        SetAllBones = function(self, check, bonetype, action)
            for k, v in self.Info.bones do
                if type(v[check]) == "table" then
                    for i, vn in v[check] do
                        if vn == bonetype then
                            v.visibility = action 
                        end
                    end
                else
                    if v[check] == bonetype then
                        v.visibility = action
                    end
                end
            end                                                
        end,   
    }    
end

function GateWallUnit(SuperClass)
    return Class(SuperClass) {
        OnCreate = function(self)
            SuperClass.OnCreate(self)  
            self.Slider = CreateSlider(self, 0)   
            self.Trash:Add(self.Slider) 
        end,
             
        OnStopBeingBuilt = function(self,builder,layer)
            SuperClass.OnStopBeingBuilt(self, builder, layer) 
            self:ToggleGate('open')
        end,
        
        ToggleGate = function(self, order)
            local depth = self:GetBlueprint().Display.GateOpenHeight or 40
            if order == 'open' then  
                self.Slider:SetGoal(0, depth, 0)   
                self.Slider:SetSpeed(200)
                if self.blocker then
                   self.blocker:Destroy()
                   self.blocker = nil
                end      
            end
            if order == 'close' then  
                self.Slider:SetGoal(0, 0, 0)      
                self.Slider:SetSpeed(200)
                if not self.blocker then
                   local pos = self:GetPosition()
                   self.blocker = CreateUnitHPR('ZZZ5301',self:GetArmy(),pos[1],pos[2],pos[3],0,0,0)
                   self.Trash:Add(self.blocker)
                end      
            end
        end,      
        
        OnScriptBitSet = function(self, bit)
            if bit == 1 then                      
                self:ToggleGate('close')
            end
            SuperClass.OnScriptBitSet(self, bit)
            if bit == 1 then                
                for k, v in self.Info.ents do
                    if v.val[1] then
                        v.ent:SetScriptBit('RULEUTC_WeaponToggle',true)
                    end 
                end              
            end
        end,  
          
        OnScriptBitClear = function(self, bit)
            if bit == 1 then   
                self:ToggleGate('open')
            end
            SuperClass.OnScriptBitClear(self, bit)
            if bit == 1 then   
                for k, v in self.Info.ents do
                    if v.val[1] then
                        v.ent:SetScriptBit('RULEUTC_WeaponToggle',false)
                    end 
                end               
            end
        end, 
        
        OnKilled = function(self, instigator, type, overkillRatio)
            SuperClass.OnKilled(self, instigator, type, overkillRatio)
            if self.blocker then
               self.blocker:Destroy()
            end      
        end,
        
        OnDestroy = function(self)
            if self.blocker then
               self.blocker:Destroy()
            end      
            SuperClass.OnDestroy(self)
        end,
    }    
end
