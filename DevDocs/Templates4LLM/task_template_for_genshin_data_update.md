# 本文只是 Template。實際分派任務時需要事主指定原神遊戲版本號與角色編號。
````
var ver = 7.0
var chars: [String: String] = [
	"Odette": "10000150",
	"Alyosha": "10000148",
	"Sora (Cryo)": "10000005-cryo",
	"Hotaru (Cryo)": "10000007-cryo",
]
````
[新任务] 任务：阅读下述角色（取自原神 $(ver) 更新）的数值策划资料，然后在 `ArtifactRatingDB/Sources/ArtifactRatingDB/Resources/ARDB4GI.json` 内新增对应的角色的圣遗物评分模型数据。
```
for (character, cid) in chars {
	https://gi.yatta.moe/api/v2/chs/avatar/$(cid)
}
```

生成圣遗物评分模型数据之前，可以先熟悉既有的（原神 $(ver - 1) 为止的角色）的圣遗物评分模型特征。这可以帮助你让你生成的新角色的圣遗物评分模型保持统一的行为特征。

必读参考资料：
- `PizzaHelperUnited/Packages/EnkaKit/Sources/EnkaKit/`（尤其是 `Packages/EnkaKit/Sources/EnkaKit/EnkaKitBackend/ArtifactRating`）可以用来帮助你了解拿铁小助手的圣遗物评分系统是怎样同时服务 星穹铁道 与 原神 的角色的。
- 所有角色的 ID 清单：`https://gi.yatta.moe/api/v2/chs/avatar`
- Yatta API 不能同时多次访问，你必须逐次访问。这是他们 server 的限制。
- 如果这版本有 Hotaru 与 Sora 的更新的话，应该是他们在这个版本新增了X元素分支能力。
