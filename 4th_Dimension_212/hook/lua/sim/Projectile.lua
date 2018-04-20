local DefaultExplosion = import('/lua/defaultexplosions.lua')
do
local OldProjectile = Projectile
Projectile = Class(OldProjectile) {

    DoTaperedDamage = function(self, instigator, damageRadius, damage, damageType, damageFriendly, damageSelf, EdgeDamageRatio)
        if damageRadius and damage then
            local Run1Step = false
            if not EdgeDamageRatio then
                Run1Step = true
            else
                if EdgeDamageRatio >= 1 then
                    Run1Step = true
                end
            end
            if damageRadius < 2 then
                Run1Step = true
            end
            if Run1Step then
                DamageArea(instigator, self:GetPosition(), damageRadius, damage, damageType or 'Normal', damageFriendly or true, damageSelf or false)
            else
                local EdgeDamage = damage * EdgeDamageRatio
                local HalfWay = math.ceil(damageRadius / 2)
                local EdgeFloor = math.floor(damageRadius)
                local StepCount = EdgeFloor - HalfWay
                local DamageFalloff = damage - EdgeDamage
                local StepDamage = DamageFalloff / StepCount
                local ThisDamageRing = HalfWay
                for i=1,StepCount do
                    DamageArea(instigator, self:GetPosition(), ThisDamageRing, StepDamage, damageType or 'Normal', damageFriendly or true, damageSelf or false)
                    ThisDamageRing = ThisDamageRing + 1
                end
                DamageArea(instigator, self:GetPosition(), damageRadius, EdgeDamage, damageType or 'Normal', damageFriendly or true, damageSelf or false)
            end
        end
    end,

    PassDamageData = function(self, damageData)
        OldProjectile.PassDamageData(self,damageData)
        self.DamageData.EdgeDamageRatio = damageData.EdgeDamageRatio
    end,

} TypeClass = Projectile
end
