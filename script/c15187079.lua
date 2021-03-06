--地縛神 Uru
function c15187079.initial_effect(c)
	--only 1 can exists
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c15187079.excon)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(c15187079.splimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c15187079.sdcon)
	c:RegisterEffect(e4)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--direct atk
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
	--damage
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(15187079,0))
	e7:SetCategory(CATEGORY_CONTROL)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCost(c15187079.ctcost)
	e7:SetTarget(c15187079.cttg)
	e7:SetOperation(c15187079.ctop)
	c:RegisterEffect(e7)
end
function c15187079.exfilter(c,fid)
	return c:IsFaceup() and c:IsSetCard(0x21) and (fid==nil or c:GetFieldID()<fid)
end
function c15187079.excon(e)
	return Duel.IsExistingMatchingCard(c15187079.exfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c15187079.splimit(e,se,sp,st,spos,tgp)
	if bit.band(spos,POS_FACEDOWN)~=0 then return true end
	return not Duel.IsExistingMatchingCard(c15187079.exfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c15187079.sdcon(e)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) or c:IsHasEffect(67987302) then return false end
	local f1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local f2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	return ((f1==nil or not f1:IsFaceup()) and (f2==nil or not f2:IsFaceup()))
		or Duel.IsExistingMatchingCard(c15187079.exfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetFieldID())
end
function c15187079.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,e:GetHandler())
	Duel.Release(g,REASON_EFFECT)
end
function c15187079.filter(c)
	return c:IsFaceup() and c:IsAbleToChangeControler()
end
function c15187079.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c15187079.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c15187079.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c15187079.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c15187079.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not Duel.GetControl(tc,tp,PHASE_END,1) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
