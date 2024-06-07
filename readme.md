# kof95

Disassembly of The King of Fighters '95 for the Game Boy, also known as:
* 熱闘 ザ・キング・オブ・ファイターズ ’９５
* Nettou King of Fighters '95

## Building
This will build bit-perfect ROMs of the Japanese version of KOF95.

To assemble, run one of the included batch scripts:
- **build-jp.cmd** for the Japanese version. To verify this, provide a ROM named "*Nettou The King of Fighters '95 (Japan) (SGB Enhanced).gb*" as "*original_jp.gb*". `sha1: AF48F83D5DC319AA1E373B8E91EDE45606BD867C`
- **build-96f.cmd** for "Fake 96", which is a bootleg hack that pretends to be 96. To verify this, provide a ROM named "*kof96-512k.gb*" as "*original_96f.gb*". `sha1: 91C21A2B2039654C2EB0C2181942AE4BB48D51BB`
- **build-nojunk.cmd** for a version of the game without padding areas. Currently, it builds a version with more lenient move inputs and less slowdown.

## 
Special thanks:
- Once more, to lazigamer for the debug emulator used to generate the initial CDL.
- To taizou for providing a ROM of the fake KOF 96.
## 
*even though it started in 95...*