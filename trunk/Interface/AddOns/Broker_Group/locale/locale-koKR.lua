local L = LibStub("AceLocale-3.0"):NewLocale("Broker_Group","koKR")
if not L then return end

L["Minimalistic LDB plugin to track down rolls and perform basic loot functions."] = true
L["Solo"] = "솔로잉"
L["group"] = "주사위 굴림"
L["master"] = "담당자가 획득"
L["freeforall"] = "자유 획득"
L["roundrobin"] = "차례대로 획득"
L["needbeforegreed"] = "주사위 굴림"
L["ML (%s)"] = "담당자 (%s)"
L["No rolls"] = "주사위 없음"

L["Roll ending in 5 seconds, recorded %d of %d rolls."] = "주사위 굴리기가 5초 안에 종료됩니다. %d/%d 주사위 굴림."

L["Winner: %s."] = "우승자는 %s님 입니다."
L[", "] = ", "
L["Tie: %s are tied at %d."] = "%s (%d/%d)"
L["%s (%d/%d)"] = "%s (%d/%d)"
L["%s [%s]"] = "%s [%s]"
L["%d of expected %d rolls recorded."] = "%d / %d 를 기록했습니다."

L["Perform roll when clicked"] = "클릭했을때 주사위 굴림"
L["Perform a standard 1-100 roll when the plugin is clicked."] = "클릭했을때 1-100의 표준 주사위를 굴립니다."
L["Announce"] = "카운트 후 결과 "
L["Only accept 1-100"] = "1-100만 인정"
L["Accept standard (1-100) rolls only."] = "표준 주사위(1-100)만 인정합니다."
L["Set the loot type."] = "아이템 획득 방식을 변경합니다."
L["Loot threshold"] = "아이템 획득 등급"
L["Set the loot threshold."] = "아이템 획득 등급을 변경합니다."

L["Where to output roll results."] = "결과 표시 위치를 선택해 주세요."
L["Auto (based on group)"] = "자동 (파티 및 공격대에 따라 자동"
L["Local"] = "개인 화면에 표시"
L["Say"] = "일반창에 표시"
L["Party"] = "파티창에 표시"
L["Raid"] = "공격대창에 표시"
L["Guild"] = "길드창에 표시"
L["Don't announce"] = "표시하지 않음"

L["Roll clearing"] = "주사위 리스트 제거"
L["When to clear the rolls."] = "주사위 리스트를 언제 제거할지 설정합니다."
L["Never"] = "없음"
L["10 seconds"] = "10 초"
L["15 seconds"] = "15 초"
L["30 seconds"] = "30 초"
L["45 seconds"] = "45 초"
L["60 seconds"] = "60 초"

L["Roll"] = "주사위"
L["Player"] = "플레이어"
L["Loot method"] = "아이템 획득 방법"
L["Master looter"] = "아이템 담당자"
L["Leader"] = "공격대장"
L["Officers"] = "지휘관"
L["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55f클릭|r - 주사위 굴리기, |cffeda55fCtrl-클릭|r - 우승자 출력, |cffeda55fShift-Click|r -주사위 리스트 제거"
L["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fCtrl-클릭|r - 우승자 출력, |cffeda55fShift-Click|r -주사위 리스트 제거"

L["Pass"] = "패스"
L["Everyone passed."] = "모두 패스합니다."
	
L["Leave Party"] = "파티 탈퇴"
L["Leave your current party or raid."] = "당신의 현재 파티나 공격대를 떠납니다."
	
L["Reset Instances"] = "인스턴스 초기화"
L["Reset all available instance the group leader has active."] = "공격대장이거나 파티장일때 모든 인스턴스 초기화 기능을 사용합니다."

-- Translation needed
--L["Dungeon Difficulty"] = true
--L["Set the dungeon difficulty for instances."] = true
--L["Pass on random loot"] = true
--L["Enable this setting to auto-pass on random loot."] = true

--L["Raid Difficulty"] = true
--L["Set the raid difficulty for instances."] = true
--L["Show instance difficulty"] = true
--L["Toggles instance difficulty display on the button/block."] = true
--L["Difficulty type"] = true
--L["Set the difficulty type text shown on the button/block. 'Auto' means the difficulty will only be shown if you are grouped and will reflect your group type."] = true
--L["Show loot method"] = true
--L["Toggles loot method display on the button/block."] = true

--L["5 N"] = true
--L["5 H"] = true
--L["10 N"] = true
--L["25 N"] = true
--L["10 H"] = true
--L["25 H"] = true
--L["Short text for instance difficulty"] = true
--L["Trims the instance difficulty text label. For example 25 player Heroic difficulty will display as '25 H'."] = true