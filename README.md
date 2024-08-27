# ArtifactRatingDB

The artifact rating model database used by Pizza Helper to rate artifacts used in Genshin Impact and Star Rail.

## How these data work?

Methods used for rating artifacts differ among games:

- Star Rail: See [Mobyw's instructions](https://github.com/Mar-7th/StarRailScore/blob/master/README.md).
- Genshin Impact: 
	- While the data models of most characters are from Alice workshop, the method will be replaced by a new one derived from Mobyw's method (mentioned above). This needs extra work since I didn't find the method of calculating the steps of subprops of artifacts in Genshin.

## Credits

All Swift program files under this repository are licensed under `AGPL-3.0-or-later` license.

Credits for the data model source used against Star Rail:

- **Mobyw**: 
    - Almost all characters. Consult [this repository](https://github.com/Mar-7th/StarRailScore) for more information.
- **Shiki Suen** ((c) 2024 and onwards Pizza Studio, MIT License):
    - Only those latest characters not yet implemented by MobyW. These data usually get replaced by Mobyw's models (when available).

Credits for the data model source used against Genshin Impact:

- **Wu Xiaoyun** ((c) 2023 and onwards Alice Workshop, MIT License): 
	- **Horizon**: Aloy.
	- **Mondstadt**: Thoma, Sucrose, Kaeya, Amber, Lisa, Venti, Klee, Jean, Diluc, Bennett, Fischl, Albedo, Mona, Rosaria, Diona, Mika, Razor, Noelle.
	- **Liyue**: Zhongli, Qiqi, Yunjin, Xingqiu, Xiangling, Xiao, Hutao, Ganyu, Yelan, Keqing, Shenhe, Beidou, Ningguang, Yanfei, Yaoyao, Chongyun.
	- **Inazuma**: Kunikuzushi (雷电国崩), Miko (八重神子), Raiden Ei (雷电影), Itto, Kazuha, Ayaka, Ayato, Yoimiya, Kokomi, Shinobu, Sara, Gorou, Heizou, Sayu, 
	- **Sumeru**: Cyno, Alhaitham, Nahida, Nilou, Tighnari, Dehya, Faruzan, Layla, Collei, Dori, Candace.
	- **Fountaine**: Lyney.
	- **Snezhnaya**: Tartaglia.
- **Kamihimmel** ((c) 2023 and onwards Alice Workshop, MIT License): 
	- **Fountaine**: Wriothesley, Neuvillette, Furina, Navia, Chiori, Clorinde.
	- **Snezhnaya**: Arlecchino.
- **Shiki Suen** ((c) 2023 and onwards Pizza Studio, MIT License):
	- **Protagonists**: Hotaru, Sora.
	- **Mondstadt**: Eula, Barbara.
	- **Liyue**: Baizhu, Xinyan, Gaming, Xianyun.
	- **Inazuma**: Kirara.
	- **Sumeru**: Kaveh, Sethos.
	- **Fountaine**: Lynette, Freminet, Charlotte, Cheuvreuse, Sigewinne, Emilie.
	- **Natlan**: Kinich, Mualani, Kachina.

$ EOF.
 