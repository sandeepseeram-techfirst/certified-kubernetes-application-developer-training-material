curl -s https://fluxcd.io/install.sh | bash

cd /usercode

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=flux-infra \
  --branch=main \
  --path=./educative-cluster \
  --personal 

git clone https://github.com/$GITHUB_USER/flux-infra

cd /usercode/flux-infra
 
flux create source git podinfo \
  --url=https://github.com/mabbas123456/system \
  --branch=main \ 
  --interval=30s \
  --export > ./educative-cluster/podinfo-source.yaml

git add -A && git commit -m "Add podinfo GitRepository"
git push -f

flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./infrastructure" \
  --prune=true \
  --interval=5m \
  --export > ./educative-cluster/podinfo-kustomization.yaml

git add -A && git commit -m "Add podinfo GitRepository"
git push -f
