--竜宮の白タウナギ
function c37953640.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c37953640.syntg)
	e1:SetValue(1)
	e1:SetOperation(c37953640.synop)
	c:RegisterEffect(e1)
end
c37953640.tuner_filter=aux.FilterBoolFunction(Card.IsRace,RACE_FISH)
function c37953640.synfilter(c,syncard,f)
	return c:IsFaceup() and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard) and c:IsRace(RACE_FISH) and (f==nil or f(c))
end
function c37953640.syntg(e,syncard,f,minc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	if lv<=0 then return false end
	local g=Duel.GetMatchingGroup(c37953640.synfilter,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,f)
	local res=g:CheckWithSumEqual(Card.GetSynchroLevel,lv,minc,syncard)
	return res
end
function c37953640.synop(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	local g=Duel.GetMatchingGroup(c37953640.synfilter,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,f)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local sg=g:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv,minc,syncard)
	Duel.SetSynchroMaterial(sg)
end
