-- compute the apparent ecliptic longitude of the Sun at now
-- https://en.wikipedia.org/wiki/Position_of_the_Sun#Ecliptic_coordinates

local rad = math.rad
sin = function (x) return math.sin(rad(x)) end
local floor = math.floor

-- TODO instead of use now, use 23:59:59 of the day

epoch = os.time()
-- epoch seconds of J2000.0
-- obtained by
-- date --date="2000-01-01T12:00:00Z" +%s
n = (epoch - 94672800) / 86400
L = 280.260 + 0.9856474*n
g = 357.528 + 0.9856003*n
lon = L + 1.915*sin(g) + 0.020*sin(2*g)
lon = floor(lon % 360)
pentad = lon * 72 // 360
term = pentad // 3
pentad = pentad % 3

pentad_tbl = {
  {"春分",{"玄鳥至",  "雷乃發聲",        "始電"},        {"白羊宮", "A"}},  
  {"清明",{"桐始華",  "田鼠化鴽",        "虹始見"},      {"白羊宮", "A"}},
  {"穀雨",{"萍始生",  "鳴鳩拂羽",        "戴勝降於桑"},  {"金牛宮", "B"}},
  {"立夏",{"螻蟈鳴",  "蚯蚓出",          "王瓜生"},      {"金牛宮", "B"}},
  {"小滿",{"苦菜秀",  "扉草死",          "小暑至"},      {"雙子宮", "C"}},
  {"芒種",{"螗螂生",  "鵙始鳴",          "反舌無聲"},    {"雙子宮", "C"}},
  {"夏至",{"鹿角解",  "蜩始鳴",          "半夏生"},      {"巨蟹宮", "D"}},
  {"小暑",{"溫風至",  "蟋蟀居壁",        "鷹乃學習"},    {"巨蟹宮", "D"}},
  {"大暑",{"腐草為螢","土潤溽暑",        "大雨時行"},    {"獅子宮", "E"}},
  {"立秋",{"涼風至",  "白露降",          "寒蟬鳴"},      {"獅子宮", "E"}},
  {"處暑",{"鷹乃祭鳥","天地始肅",        "禾乃登"},      {"処女宮", "F"}},
  {"白露",{"鴻鴈來",  "元鳥歸",          "群鳥養羞"},    {"処女宮", "F"}},
  {"秋分",{"雷乃收聲","蟄蟲坯戶",        "水始涸"},      {"天秤宮", "G"}},
  {"寒露",{"鴻鴈來賓","雀入水為蛤",      "菊有黃華"},    {"天秤宮", "G"}},
  {"霜降",{"豺乃祭獸","草木黃落",        "蟄蟲咸俯"},    {"天蝎宮", "H"}},
  {"立冬",{"水始冰",  "地始凍",          "雉入大水為蜃"},{"天蝎宮", "H"}},
  {"小雪",{"虹藏不見","天氣上騰地氣下降","閉塞而成冬"},  {"人馬宮", "I"}},
  {"大雪",{"鶡鳥不鳴","虎始交",          "荔挺出"},      {"人馬宮", "I"}},
  {"冬至",{"蚯蚓結",  "麋角解",          "水泉動"},      {"磨羯宮", "J"}},
  {"小寒",{"鴈北鄉",  "鵲姑巢",          "雉始雊"},      {"磨羯宮", "J"}},
  {"大寒",{"雞始乳",  "鷙鳥厲疾",        "水澤腹堅"},    {"宝瓶宮", "K"}},
  {"立春",{"東風解凍","蟄蟲始振",        "魚上冰"},      {"宝瓶宮", "K"}},
  {"雨水",{"獺祭魚",  "鴻鴈來",          "草木萌動"},    {"双魚宮", "L"}},
  {"驚蟄",{"桃始華",  "倉庚鳴",          "鷹化為鳩"},    {"双魚宮", "L"}}
}
month_tbl = {
  "睦月",
  "如月",
  "弥生",
  "卯月",
  "皐月",
  "水無月",
  "文月",
  "葉月",
  "長月",
  "神無月",
  "霜月",
  "師走",
}
youbi_tbl = {
  {"日曜日", "Q"},
  {"月曜日", "R"},
  {"火曜日", "U"},
  {"水曜日", "S"},
  {"木曜日", "V"},
  {"金曜日", "T"},
  {"土曜日", "W"},
}
date = os.date("*t", epoch)
term = pentad_tbl[term+1]
zodiac = term[3]
youbi = youbi_tbl[date.wday]
format_str = "%%{T3}ﭷ %%{T-}%04d 年 %s %02d 日 %s %s %s %s %%{T3} %%{T-}%s %02d:%02d"
print(string.format(format_str,
  date.year,              -- YYYY
  month_tbl[date.month],  -- name of the Month
  date.day,               -- DD
  "%{T5}" .. youbi[2] .. " %{T-}" .. youbi[1],
  (                       -- zidiac
    "%{T5}" .. zodiac[2] .. " %{T-}" .. zodiac[1]
  ),
  term[1],                -- solar term
  term[2][pentad+1],      -- pentad
  (
    date.hour >= 12 and "午後" or "午前"
  ),
  date.hour - (date.hour > 12 and 12 or 0),
  date.min
))
