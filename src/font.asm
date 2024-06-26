;
; FONT DEFINITIONS
;
; This game's default font is ASCII, with no Japanese characters.
;
; Any instance of Japanese is handled by a specific fonts containing a subset of characters.
; Since it's tailor-made for each screen, they could get away with including some Kanji in here. 8x8 Kanji.
;

PUSHC

NEWCHARMAP intro

; [TCRF] The Japanese intro font was remapped from $40 to $00 for the English version.
IF VER_EN
DEF TOFFSET = $00
ELSE
DEF TOFFSET = $40
ENDC
	CHARMAP " ", TOFFSET + $00 
	CHARMAP "1", TOFFSET + $01
	CHARMAP "9", TOFFSET + $02
	CHARMAP "5", TOFFSET + $03
	CHARMAP "年", TOFFSET + $04 
	CHARMAP "。", TOFFSET + $05
	CHARMAP "K", TOFFSET + $06
	CHARMAP "I", TOFFSET + $07
	CHARMAP "N", TOFFSET + $08
	CHARMAP "G", TOFFSET + $09
	CHARMAP "O", TOFFSET + $0A
	CHARMAP "F", TOFFSET + $0B
	CHARMAP "H", TOFFSET + $0C
	CHARMAP "T", TOFFSET + $0D
	CHARMAP "E", TOFFSET + $0E
	CHARMAP "R", TOFFSET + $0F
	CHARMAP "S", TOFFSET + $10
	CHARMAP "を", TOFFSET + $11
	CHARMAP "開", TOFFSET + $12 
	CHARMAP "催", TOFFSET + $13 
	CHARMAP "す", TOFFSET + $14 
	CHARMAP "る", TOFFSET + $15
	CHARMAP "対", TOFFSET + $16 
	CHARMAP "戦", TOFFSET + $17 
	CHARMAP "方", TOFFSET + $18 
	CHARMAP "式", TOFFSET + $19 
	CHARMAP "は", TOFFSET + $1A 
	CHARMAP "前", TOFFSET + $1B 
	CHARMAP "回", TOFFSET + $1C 
	CHARMAP "同", TOFFSET + $1D 
	CHARMAP "様", TOFFSET + $1E 
	CHARMAP "チ", TOFFSET + $1F
	CHARMAP "-", TOFFSET + $20
	CHARMAP "ム", TOFFSET + $21
	CHARMAP "に", TOFFSET + $22
	CHARMAP "て", TOFFSET + $23
	CHARMAP "と", TOFFSET + $24
	CHARMAP "り", TOFFSET + $25
	CHARMAP "行", TOFFSET + $26 
	CHARMAP "う", TOFFSET + $27
	CHARMAP "大", TOFFSET + $28 
	CHARMAP "会", TOFFSET + $29 
	CHARMAP "参", TOFFSET + $2A 
	CHARMAP "加", TOFFSET + $2B
	CHARMAP "者", TOFFSET + $2C 
	CHARMAP "の", TOFFSET + $2D
	CHARMAP "再", TOFFSET + $2E
	CHARMAP "心", TOFFSET + $2F
	CHARMAP "待", TOFFSET + $30
	CHARMAP "ち", TOFFSET + $31
	CHARMAP "し", TOFFSET + $32
	CHARMAP "い", TOFFSET + $33
	CHARMAP "以", TOFFSET + $34
	CHARMAP "上", TOFFSET + $35
	CHARMAP "・", TOFFSET + $36 
	CHARMAP "[", TOFFSET + $37
	CHARMAP "<R>", TOFFSET + $38
	CHARMAP "]", TOFFSET + $39
	
NEWCHARMAP hudchar
	CHARMAP " ", $00 ; [TCRF] Empty space not used 
	CHARMAP "T", $01
	CHARMAP "K", $02
	CHARMAP "Y", $03
	CHARMAP "E", $04 
	CHARMAP "R", $05
	CHARMAP "O", $06
	CHARMAP "B", $07
	CHARMAP "N", $08
	CHARMAP "I", $09
	CHARMAP "J", $0A
	CHARMAP "M", $0B
	CHARMAP "A", $0C
	CHARMAP "U", $0D
	CHARMAP "H", $0E
	CHARMAP "D", $0F
	CHARMAP "L", $10
	CHARMAP "F", $11
	CHARMAP "S", $12 
	CHARMAP "G", $13 

NEWCHARMAP winscr
	CHARMAP " ", $08
	CHARMAP "オ", $09
	CHARMAP "レ", $0A
	CHARMAP "の", $0B
	CHARMAP "炎", $0C
	CHARMAP "で", $0D
	CHARMAP "も", $0E
	CHARMAP "え", $0F
	CHARMAP "つ", $10
	CHARMAP "き", $11
	CHARMAP "ち", $12
	CHARMAP "ま", $13
	CHARMAP "い", $14
	CHARMAP "な", $15
	CHARMAP "!", $16
	CHARMAP "よ", $17
	CHARMAP "わ", $18
	CHARMAP "ヤ", $19
	CHARMAP "ツ", $1A
	CHARMAP "に", $1B
	CHARMAP "は", $1C
	CHARMAP "う", $1D
	CHARMAP "ね", $1E
	CHARMAP "ぜ", $1F
	CHARMAP "く", $20
	CHARMAP "や", $21
	CHARMAP "っ", $22
	CHARMAP "た", $23
	CHARMAP "と", $24
	CHARMAP "お", $25
	CHARMAP "が", $26
	CHARMAP "、", $27
	CHARMAP "舌", $28
	CHARMAP "び", $29
	CHARMAP "る", $2A
	CHARMAP "小", $2B
	CHARMAP "羊", $2C
	CHARMAP "み", $2D
	CHARMAP "だ", $2E
	CHARMAP "修", $2F
	CHARMAP "行", $30
	CHARMAP "し", $31
	CHARMAP "て", $32
	CHARMAP "強", $33
	CHARMAP "れ", $34
	CHARMAP "そ", $35
	CHARMAP "以", $36
	CHARMAP "上", $37
	CHARMAP "を", $38
	CHARMAP "私", $39
	CHARMAP "ど", $3A
	CHARMAP "こ", $3B
	CHARMAP "ん", $3C
	CHARMAP "か", $3D
	CHARMAP "ぁ", $3E
	CHARMAP "。", $3F
	CHARMAP "ぱ", $40
	CHARMAP "り", $41
	CHARMAP "さ", $42
	CHARMAP "テ", $43
	CHARMAP "へ", $44
	CHARMAP "技", $45
	CHARMAP "根", $46
	CHARMAP "性", $47
	CHARMAP "ぃ", $48
	CHARMAP "マ", $49
	CHARMAP "ジ", $4A
	CHARMAP "戦", $4B
	CHARMAP "ゅ", $4C
	CHARMAP "ば", $4D
	CHARMAP "ら", $4E
	CHARMAP "カ", $4F
	CHARMAP "べ", $50
	CHARMAP "あ", $51
	CHARMAP "士", $52
	CHARMAP "次", $53
	CHARMAP "試", $54
	CHARMAP "合", $55
	CHARMAP "L", $56
	CHARMAP "E", $57
	CHARMAP "T", $58
	CHARMAP "'", $59
	CHARMAP "S", $5A
	CHARMAP "G", $5B
	CHARMAP "O", $5C
	CHARMAP "今", $5D
	CHARMAP "す", $5E
	CHARMAP "せ", $5F
	CHARMAP "ぎ", $60
	CHARMAP "む", $61
	CHARMAP "女", $62
	CHARMAP "ふ", $63
	CHARMAP "ゆ", $64
	CHARMAP "け", $65
	CHARMAP "ム", $66
	CHARMAP "ダ", $67
	CHARMAP "ろ", $68
	CHARMAP "忍", $69
	CHARMAP "術", $6A
	CHARMAP "じ", $6B
	CHARMAP "ょ", $6C
	CHARMAP "如", $6D
	CHARMAP "月", $6E
	CHARMAP "流", $6F
	CHARMAP "ゃ", $70
	CHARMAP "イ", $71
	CHARMAP "ヌ", $72
	CHARMAP "モ", $73
	CHARMAP "ノ", $74
	CHARMAP "め", $75
	CHARMAP "ぶ", $76
	CHARMAP "存", $77
	CHARMAP "在", $78
	
NEWCHARMAP intboss
	CHARMAP " ", $00
	CHARMAP "ル", $01
	CHARMAP "ガ", $02
	CHARMAP "ー", $03
	CHARMAP "さ", $04
	CHARMAP "ま", $05
	CHARMAP "・", $06
	CHARMAP "。", $07
	CHARMAP "フ", $08
	CHARMAP "ッ", $09
	CHARMAP "、", $0A
	CHARMAP "そ", $0B
	CHARMAP "の", $0C
	CHARMAP "と", $0D
	CHARMAP "お", $0E
	CHARMAP "り", $0F
	CHARMAP "だ", $10
	CHARMAP "こ", $11
	CHARMAP "れ", $12
	CHARMAP "で", $13
	CHARMAP "い", $14
	CHARMAP "き", $15
	CHARMAP "て", $16
	CHARMAP "め", $17
	CHARMAP "を", $18
	CHARMAP "ら", $19
	CHARMAP "し", $1A
	CHARMAP "た", $1B
	CHARMAP "私", $1C
	CHARMAP "も", $1D
	CHARMAP "や", $1E
	CHARMAP "っ", $1F
	CHARMAP "!", $20
	CHARMAP "す", $21
	CHARMAP "ば", $22
	CHARMAP "ど", $23
	CHARMAP "ょ", $24
	CHARMAP "う", $25
	CHARMAP "ひ", $26
	CHARMAP "ん", $27
	CHARMAP "力", $28
	CHARMAP "に", $29
	CHARMAP "く", $2A
	CHARMAP "る", $2B
	CHARMAP "オ", $2C
	CHARMAP "わ", $2D
	CHARMAP "が", $2E
	CHARMAP "は", $2F
	CHARMAP "ビ", $30
	CHARMAP "ジ", $31
	CHARMAP "ネ", $32
	CHARMAP "ス", $33
	CHARMAP "協", $34
	CHARMAP "な", $35
	CHARMAP "?", $36
	CHARMAP "キ", $37
	CHARMAP "ミ", $38
	CHARMAP "ち", $39
	CHARMAP "最", $3A
	CHARMAP "強", $3B
	CHARMAP "人", $3C
	CHARMAP "間", $3D
	CHARMAP "兵", $3E
	CHARMAP "器", $3F
	CHARMAP "か", $40
	CHARMAP "ぞ", $41
	CHARMAP "よ", $42
	CHARMAP "ろ", $43
	CHARMAP "び", $44
	CHARMAP "え", $45
	CHARMAP "み", $46
	CHARMAP "ず", $47
	CHARMAP "型", $48
	CHARMAP "戦", $49
	CHARMAP "つ", $4A
	CHARMAP "ワ", $4B
	CHARMAP "シ", $4C
	CHARMAP "ク", $4D
	CHARMAP "サ", $4E
	CHARMAP "ナ", $4F
	CHARMAP "ギ", $50
	CHARMAP "イ", $51
	CHARMAP "ュ", $52
	CHARMAP "ウ", $53
	CHARMAP "あ", $54
	CHARMAP "せ", $55
	CHARMAP "ね", $56
	CHARMAP "ぬ", $57
	CHARMAP "チ", $58
	CHARMAP "ム", $59
	CHARMAP "6", $5A
	CHARMAP "ゅ", $5B
	CHARMAP "じ", $5C
	CHARMAP "け", $5D
	CHARMAP "ハ", $5E
	CHARMAP "ョ", $5F
	CHARMAP "ぜ", $60
	CHARMAP "タ", $61
	CHARMAP "！", $62
	CHARMAP "ぽ", $63
	CHARMAP "ヤ", $64
	CHARMAP "ツ", $65
	CHARMAP "ぶ", $66
	CHARMAP "3", $67
	
NEWCHARMAP rugaldefeat
	CHARMAP " ", $00
	CHARMAP "ク", $01
	CHARMAP "ッ", $02
	CHARMAP "、", $03
	CHARMAP "こ", $04
	CHARMAP "の", $05
	CHARMAP "パ", $06
	CHARMAP "ワ", $07
	CHARMAP "ー", $08
	CHARMAP "を", $09
	CHARMAP "も", $0A
	CHARMAP "っ", $0B
	CHARMAP "て", $0C
	CHARMAP "し", $0D
	CHARMAP "か", $0E
	CHARMAP "ぬ", $0F
	CHARMAP "と", $10
	CHARMAP "は", $11
	CHARMAP "・", $12
	CHARMAP "!", $13
	CHARMAP "?", $14
	CHARMAP "な", $15
	CHARMAP "ん", $16
	CHARMAP "だ", $17
	CHARMAP "ら", $18
	CHARMAP "が", $19
	CHARMAP "。", $1A
	CHARMAP "ば", $1B
	CHARMAP "私", $1C
	CHARMAP "で", $1D
	CHARMAP "フ", $1E
	CHARMAP "ま", $1F
	CHARMAP "あ", $20
	CHARMAP "い", $21
	CHARMAP "せ", $22
	CHARMAP "ひ", $23
	CHARMAP "つ", $24
	CHARMAP "よ", $25
	CHARMAP "う", $26
	CHARMAP "す", $27
	CHARMAP "る", $28
	CHARMAP "ぎ", $29
	CHARMAP "り", $2A
	CHARMAP "ず", $2B
	CHARMAP "み", $2C
	CHARMAP "え", $2D
	CHARMAP "そ", $2E
	CHARMAP "き", $2F
	CHARMAP "に", $30
	CHARMAP "た", $31
	CHARMAP "お", $32
	CHARMAP "ょ", $33
	CHARMAP "く", $34
	
NEWCHARMAP epilogue
	CHARMAP " ", $00
	CHARMAP "こ", $01
	CHARMAP "う", $02
	CHARMAP "し", $03
	CHARMAP "て", $04
	CHARMAP "、", $05
	CHARMAP "の", $06
	CHARMAP "チ", $07
	CHARMAP "ー", $08
	CHARMAP "ム", $09
	CHARMAP "は", $0A
	CHARMAP "み", $0B
	CHARMAP "ご", $0C
	CHARMAP "と", $0D
	CHARMAP "ル", $0E
	CHARMAP "ガ", $0F
	CHARMAP "を", $10
	CHARMAP "た", $11
	CHARMAP "お", $12
	CHARMAP "キ", $13
	CHARMAP "ン", $14
	CHARMAP "グ", $15
	CHARMAP "オ", $16
	CHARMAP "ブ", $17
	CHARMAP "フ", $18
	CHARMAP "ァ", $19
	CHARMAP "イ", $1A
	CHARMAP "タ", $1B
	CHARMAP "ズ", $1C
	CHARMAP "9", $1D
	CHARMAP "5", $1E
	CHARMAP "に", $1F
	CHARMAP "ゆ", $20
	CHARMAP "よ", $21
	CHARMAP "・", $22
	CHARMAP "。", $23
	CHARMAP "そ", $24
	CHARMAP "れ", $25
	CHARMAP "ぞ", $26
	CHARMAP "あ", $27
	CHARMAP "ら", $28
	CHARMAP "な", $29
	CHARMAP "る", $2A
	CHARMAP "も", $2B
	CHARMAP "く", $2C
	CHARMAP "き", $2D
	CHARMAP "む", $2E
	CHARMAP "か", $2F
	CHARMAP "っ", $30
	CHARMAP "だ", $31
	CHARMAP "い", $32
	CHARMAP "せ", $33
	CHARMAP "1", $34
	CHARMAP "年", $35
	CHARMAP "で", $36

NEWCHARMAP charunlock
	CHARMAP " ", $00
	CHARMAP "奴", $01
	CHARMAP "は", $02
	CHARMAP "ま", $03
	CHARMAP "だ", $04
	CHARMAP "死", $05
	CHARMAP "ん", $06
	CHARMAP "で", $07
	CHARMAP "お", $08
	CHARMAP "ら", $09
	CHARMAP "!", $0A
	CHARMAP "ワ", $0B
	CHARMAP "シ", $0C
	CHARMAP "も", $0D
	CHARMAP "手", $0E
	CHARMAP "助", $0F
	CHARMAP "け", $10
	CHARMAP "い", $11
	CHARMAP "た", $12
	CHARMAP "そ", $13
	CHARMAP "う", $14
	CHARMAP "私", $15
	CHARMAP "の", $16
	CHARMAP "か", $17
	CHARMAP "げ", $18
	CHARMAP "武", $19
	CHARMAP "者", $1A
	CHARMAP "に", $1B
	CHARMAP "す", $1C
	CHARMAP "ぎ", $1D
	CHARMAP "兵", $1E
	CHARMAP "力", $1F
	CHARMAP "を", $20
	CHARMAP "え", $21
	CHARMAP "達", $22
	CHARMAP "見", $23
	CHARMAP "せ", $24
	CHARMAP "て", $25
	CHARMAP "や", $26
	CHARMAP "ろ", $27
	CHARMAP "使", $28
	CHARMAP "っ", $29
	CHARMAP "最", $2A
	CHARMAP "強", $2B
	CHARMAP "目", $2C
	CHARMAP "指", $2D
	CHARMAP "が", $2E
	CHARMAP "フ", $2F
	CHARMAP "ハ", $30
	CHARMAP "ル", $31
	CHARMAP "ガ", $32
	CHARMAP "ー", $33
	CHARMAP "&", $34
	CHARMAP "<サ2>", $35
	CHARMAP "イ", $36
	CHARMAP "ュ", $37
	CHARMAP "ウ", $38
	CHARMAP "用", $39
	CHARMAP "コ", $3A
	CHARMAP "マ", $3B
	CHARMAP "ン", $3C
	CHARMAP "ド", $3D
	CHARMAP "タ", $3E
	CHARMAP "カ", $3F
	CHARMAP "ㇻ", $40
	CHARMAP "ロ", $41
	CHARMAP "ゴ", $42
	CHARMAP "め", $43
	CHARMAP "セ", $44
	CHARMAP "レ", $45
	CHARMAP "ク", $46
	CHARMAP "ト", $47
	CHARMAP "3", $48
	CHARMAP "0", $49
	CHARMAP "回", $4A
	CHARMAP "な", $4B
	CHARMAP "こ", $4C
	CHARMAP "と", $4D
	CHARMAP "オ", $4E
	CHARMAP "チ", $4F
	CHARMAP "感", $50
	CHARMAP "じ", $51
	CHARMAP "る", $52
	CHARMAP "わ", $53
	CHARMAP "ナ", $54
	CHARMAP "2", $55
	CHARMAP "伝", $56
	CHARMAP "し", $57
	CHARMAP "大", $58
	CHARMAP "自", $59
	CHARMAP "然", $5A
	CHARMAP "き", $5B
	CHARMAP "倒", $5C
	CHARMAP "下", $5D
	CHARMAP "さ", $5E
	CHARMAP "ア", $5F
	CHARMAP "ム", $60
	CHARMAP "→", $61
	CHARMAP "↘", $62
	CHARMAP "ベ", $63
	CHARMAP "ヤ", $64
	CHARMAP "↓", $65
	CHARMAP "↙", $66
	CHARMAP "←", $67
	CHARMAP "+", $68
	CHARMAP "B", $69
	CHARMAP "ヌ", $6A
	CHARMAP "ツ", $6B
	CHARMAP "ラ", $6C
	CHARMAP "リ", $6D
	CHARMAP "つ", $6E
	CHARMAP "ペ", $6F
	CHARMAP "(", $70
	CHARMAP "<大2>", $71
	CHARMAP ")", $72
	CHARMAP "エ", $73
	CHARMAP "れ", $74
	CHARMAP "ぷ", $75
	CHARMAP "ザ", $76
	CHARMAP "ェ", $77
	CHARMAP "ブ", $78
	CHARMAP "ジ", $79
	CHARMAP "ノ", $7A
	CHARMAP "サ", $7B
	CHARMAP "ッ", $7C
	CHARMAP "↖", $7D
	CHARMAP "A", $7E
	CHARMAP "ダ", $7F
	CHARMAP "バ", $80
	CHARMAP "<ア2>", $81
	CHARMAP "プ", $82
	CHARMAP "ス", $83
	CHARMAP "ギ", $84
	CHARMAP "テ", $85
	CHARMAP "み", $86
	CHARMAP "ば", $87
	CHARMAP "鬼", $88
	CHARMAP "む", $89
	CHARMAP "り", $8A
	CHARMAP "ち", $8B
	CHARMAP "ポ", $8C ; English version only
	
NEWCHARMAP nakoruru
	CHARMAP " ", $00
	CHARMAP "ま", $01
	CHARMAP "ち", $02
	CHARMAP "な", $03
	CHARMAP "さ", $04
	CHARMAP "い", $05
	CHARMAP "!", $06
	CHARMAP "私", $07
	CHARMAP "は", $08
	CHARMAP "カ", $09
	CHARMAP "ム", $0A
	CHARMAP "イ", $0B
	CHARMAP "コ", $0C
	CHARMAP "タ", $0D
	CHARMAP "ン", $0E
	CHARMAP "の", $0F
	CHARMAP "戦", $10
	CHARMAP "士", $11
	CHARMAP "ナ", $12
	CHARMAP "ル", $13
	CHARMAP "大", $14
	CHARMAP "自", $15
	CHARMAP "然", $16
	CHARMAP "に", $17
	CHARMAP "か", $18
	CHARMAP "わ", $19
	CHARMAP "っ", $1A
	CHARMAP "て", $1B
	CHARMAP "あ", $1C
	CHARMAP "た", $1D
	CHARMAP "を", $1E
	CHARMAP "お", $1F
	CHARMAP "し", $20
	CHARMAP "す", $21
	CHARMAP "く", $22
	CHARMAP "ご", $23
	CHARMAP "オ", $24
	CHARMAP "ロ", $25
	CHARMAP "チ", $26
	CHARMAP "ぞ", $27
	CHARMAP "・", $28
	CHARMAP "き", $29
	CHARMAP "け", $2A
	CHARMAP "る", $2B
	CHARMAP "ん", $2C
	CHARMAP "ケ", $2D
	CHARMAP "ー", $2E
	CHARMAP "ッ", $2F
	CHARMAP "、", $30
	CHARMAP "マ", $31
	CHARMAP "ハ", $32
	CHARMAP "?", $33
	CHARMAP "え", $34
	CHARMAP "が", $35
	CHARMAP "う", $36
	CHARMAP "ダ", $37
	CHARMAP "ク", $38
	CHARMAP "パ", $39
	CHARMAP "ワ", $3A
	CHARMAP "こ", $3B
	CHARMAP "人", $3C
	CHARMAP "封", $3D
	CHARMAP "じ", $3E
	CHARMAP "で", $3F
	CHARMAP "。", $40
	CHARMAP "(", $41
	CHARMAP "も", $42
	CHARMAP ")", $43
	CHARMAP "そ", $44
	CHARMAP "と", $45
	CHARMAP "よ", $46
	CHARMAP "め", $47
	CHARMAP "だ", $48
	CHARMAP "れ", $49
	CHARMAP "気", $4A
	CHARMAP "フ", $4B
	CHARMAP "ほ", $4C
	CHARMAP "ろ", $4D
	CHARMAP "び", $4E
	
; English cutscene font
NEWCHARMAP ascii
	CHARMAP "↑", $01 ; ↑ ; Arrows ↓
	CHARMAP "↗", $02 ; ↗ ; Arrows ↓
	CHARMAP "→", $03 ; → ; Arrows ↓
	CHARMAP "↘", $04 ; ↘ ; Arrows ↓
	CHARMAP "↓", $05 ; ↓ ; Arrows ↓
	CHARMAP "↙", $06 ; ↙ ; Arrows ↓
	CHARMAP "←", $07 ; ← ; Arrows ↓
	CHARMAP "↖", $08 ; ↖ ; Arrows ↓
	
	; Normal ASCII
	CHARMAP " ", $20
	CHARMAP "!", $21
	CHARMAP "\"", $22
	CHARMAP "(", $28
	CHARMAP ")", $29
	CHARMAP "+", $2B
	CHARMAP ",", $2C
	CHARMAP ".", $2E
	CHARMAP "0", $30
	CHARMAP "1", $31
	CHARMAP "2", $32
	CHARMAP "3", $33
	CHARMAP "4", $34
	CHARMAP "5", $35
	CHARMAP "6", $36
	CHARMAP "7", $37
	CHARMAP "8", $38
	CHARMAP "9", $39
	CHARMAP "?", $3F
	
	CHARMAP "A", $41
	CHARMAP "B", $42
	CHARMAP "C", $43
	CHARMAP "D", $44
	CHARMAP "E", $45
	CHARMAP "F", $46
	CHARMAP "G", $47
	CHARMAP "H", $48
	CHARMAP "I", $49
	CHARMAP "J", $4A
	CHARMAP "K", $4B
	CHARMAP "L", $4C
	CHARMAP "M", $4D
	CHARMAP "N", $4E
	CHARMAP "O", $4F
	CHARMAP "P", $50
	CHARMAP "Q", $51
	CHARMAP "R", $52
	CHARMAP "S", $53
	CHARMAP "T", $54
	CHARMAP "U", $55
	CHARMAP "V", $56
	CHARMAP "W", $57
	CHARMAP "X", $58
	CHARMAP "Y", $59
	CHARMAP "Z", $5A
	
	CHARMAP "`", $60
	CHARMAP "a", $61
	CHARMAP "b", $62
	CHARMAP "c", $63
	CHARMAP "d", $64
	CHARMAP "e", $65
	CHARMAP "f", $66
	CHARMAP "g", $67
	CHARMAP "h", $68
	CHARMAP "i", $69
	CHARMAP "j", $6A
	CHARMAP "k", $6B
	CHARMAP "l", $6C
	CHARMAP "m", $6D
	CHARMAP "n", $6E
	CHARMAP "o", $6F
	CHARMAP "p", $70
	CHARMAP "q", $71
	CHARMAP "r", $72
	CHARMAP "s", $73
	CHARMAP "t", $74
	CHARMAP "u", $75
	CHARMAP "v", $76
	CHARMAP "w", $77
	CHARMAP "x", $78
	CHARMAP "y", $79
	CHARMAP "z", $7A
POPC         