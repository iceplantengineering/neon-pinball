# NEON PINBALL // CYBER ARCADE

単一HTML（index.html）で完結するネオン調ピンボール。外部依存・CDNなし。

## 操作
- Enter / クリック: ゲーム開始
- Space 長押し → 離す: プランジャーで発射
- A / ←: 左フリッパー
- D / →: 右フリッパー
- M: ミュート

## 仕様
- Canvas 2D / 固定ステップ物理（1/120s）
- バンパー3・スリング2・ドロップターゲット5（バンク5,000点）・スピナー
- 残機3 / コンボ倍率 / ハイスコアは localStorage
- WebAudio 合成によるSFX 12種＋BGMループ
- 生成: claude-glm (GLM-5.4) — 検証は headless Chromium + CDP で実キー入力
