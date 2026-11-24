#!/bin/bash
# GitHub: リポジトリ作成 → push
set -euo pipefail
set -a; source /home/moltbot/.openclaw/env; set +a
REPO="neon-pinball"
DIR="/home/moltbot/.openclaw/workspace/common/pinball-site"

echo "== whoami =="
node -e "fetch('https://api.github.com/user',{headers:{Authorization:'Bearer '+process.env.GITHUB_TOKEN}}).then(async r=>console.log(r.status,(await r.json()).login))"

echo "== create repo (404なら作成) =="
node -e "
const t=process.env.GITHUB_TOKEN;
(async()=>{
  const chk=await fetch('https://api.github.com/repos/iceplantengineering/$REPO',{headers:{Authorization:'Bearer '+t}});
  if(chk.status===200){console.log('EXISTS');return;}
  const r=await fetch('https://api.github.com/user/repos',{method:'POST',headers:{Authorization:'Bearer '+t,'Content-Type':'application/json',Accept:'application/vnd.github+json'},body:JSON.stringify({name:'$REPO',private:false,description:'NEON PINBALL - single-file pinball game (claude-glm / GLM-5.4)',auto_init:false})});
  console.log('CREATE',r.status,(await r.text()).slice(0,200));
})();
"

cd "$DIR"
if [ ! -d .git ]; then
  git init -b main
fi
git add -A
git -c user.name="iceplantengineering" -c user.email="iceplantengineering@gmail.com" commit -m "NEON PINBALL: 単一HTMLのネオンピンボール（claude-glm / GLM-5.4 生成）" || echo "nothing to commit"
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/iceplantengineering/$REPO.git"
B64=$(printf 'x-access-token:%s' "$GITHUB_TOKEN" | base64 | tr -d '\n')
git -c http.extraheader="AUTHORIZATION: basic $B64" push -u origin main
echo "== pushed =="
git log --oneline -1
