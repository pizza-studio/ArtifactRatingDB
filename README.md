# ArtifactRatingDB

The artifact rating model database used by Pizza Helper to rate artifacts used in Genshin Impact and Star Rail.

## How these data work?

Methods used for rating artifacts differ among games:

- Star Rail: See [Mobyw's instructions](https://github.com/Mar-7th/StarRailScore/blob/master/README.md).
- Genshin Impact: 
	- While the data models of most characters are from Alice workshop, the method is exactly the same as Mobyw's method (mentioned above).

## Credits

All Swift program files under this repository are licensed under `AGPL-3.0-or-later` license.

Credits for the data model source used against Star Rail:

- **Mobyw** for the method of generating the models.
- **HoYoVerse** for the initial property-usage-rate data.

Credits for the data model source used against Genshin Impact:

- **Wu Xiaoyun** ((c) 2023 and onwards Alice Workshop, MIT License): 
	- **Horizon**: Aloy.
	- **Mondstadt**: Durin, Thoma, Sucrose, Kaeya, Amber, Lisa, Venti, Klee, Jean, Diluc, Fischl, Albedo, Mona, Rosaria, Diona, Mika, Razor, Noelle.
      - Note: These are data as of `Genshin: Song of the Wekin' Moon` v6.2.
      - Since v6.3 the following characters are having their data models changed: Razor, Venti, Klee, Fischl, Albedo, Mona, Sucrose.
      - This repository will update if their artifact rating models need correspond updates.
	- **Liyue**: Zhongli, Qiqi, Yunjin, Xingqiu, Xiangling, Xiao, Hutao, Ganyu, Yelan, Keqing, Shenhe, Beidou, Ningguang, Yanfei, Yaoyao, Chongyun.
	- **Inazuma**: Kunikuzushi (雷电国崩), Miko (八重神子), Raiden Ei (雷电影), Itto, Kazuha, Ayaka, Ayato, Yoimiya, Kokomi, Shinobu, Sara, Gorou, Heizou, Sayu.
	- **Sumeru**: Cyno, Alhaitham, Nahida, Nilou, Tighnari, Dehya, Faruzan, Layla, Collei, Dori, Candace.
	- **Fountaine**: Lyney.
	- **Natlan**: Bennett.
	- **Snezhnaya**: Tartaglia.
- **Kamihimmel** ((c) 2023 and onwards Alice Workshop, MIT License): 
	- **Inazuma**: Chiori.
	- **Fountaine**: Wriothesley, Neuvillette, Furina, Navia, Clorinde.
	- **Snezhnaya**: Arlecchino.
- **Shiki Suen** ((c) 2023 and onwards Pizza Studio, MIT License):
	- **Protagonists**: Hotaru, Sora, Manekin, Manekina.
	- **Mondstadt**: Eula, Barbara, Dahlia.
	- **Liyue**: Baizhu, Xinyan, Gaming, Xianyun, Lan Yan, Zibai.
	- **Inazuma**: Kirara, Mizuki.
	- **Sumeru**: Kaveh, Sethos, Nefer.
	- **Fountaine**: Lynette, Freminet, Charlotte, Cheuvreuse, Sigewinne, Emilie, Escoffier,
	- **Natlan**: Kinich, Mualani, Kachina, Xilonen, Chasca, Ororon, Mavuika, Citlali, Iansan, Varesa, Ifa.
	- **Snezhnaya**: Ineffa.
  - **Nod-Krai**: Lauma, Flins, Aino, Jahoda, Columbina, Illuga.
  - **To be categorized**: Skirk.

$ EOF.
