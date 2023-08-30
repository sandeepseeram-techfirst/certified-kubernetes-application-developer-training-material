cd /usercode/system
mv conf .gitignore
export GH_TOKEN={{GITHUB_PAT}}
git config --global credential.helper store 
git config --global user.email "seerams@acm.org"
git config --global user.name "ACM Technologies"
echo "https://{{GITHUB_USERNAME}}:{{GITHUB_PAT}}@github.com" >> ~/.git-credentials
git init
git add .gitignore 
git commit -m "Lesson started"
git add .
git commit -m "Remaining lesson files"
git branch -m main

gh repo delete system --confirm
gh repo create system --public -s $(pwd) --push