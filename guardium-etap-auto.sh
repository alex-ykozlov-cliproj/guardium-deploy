NAME_SUFFIX=test-10
GUARDIUM_HOST=20.246.81.102
DB_HOST=sqlserver02.database.windows.net
DB_PORT=1433
DB_TYPE=mssql

#git clone https://github.com/alex-ykozlov-cliproj/guardium-deploy.git
#cd guardium-deploy

TMPL_FILE=./guardium-etap-template.values.yaml
DEST_FILE=./estap/gitops/ocp-demo/guardium-estap-${NAME_SUFFIX}/values.yaml
mkdir ./estap/gitops/ocp-demo/guardium-estap-${NAME_SUFFIX}
sed -e 's/{NAME_SUFFIX}/'$NAME_SUFFIX'/;s/{GUARDIUM_HOST}/'$GUARDIUM_HOST'/;s/{DB_HOST}/'$DB_HOST'/;s/{DB_PORT}/'$DB_PORT'/;s/{DB_TYPE}/'$DB_TYPE'/' ${TMPL_FILE} > ${DEST_FILE}

echo "New estap '${NAME_SUFFIX}' is configuration is created in ./estap/gitops/ocp-demo/guardium-estap-${NAME_SUFFIX} directory"

git add .
git commit -m "Add new values.yaml for the guardium deployment '${NAME_SUFFIX}'"
git push

echo "New estap '${NAME_SUFFIX}' is configuration is pushed to git https://github.com/alex-ykozlov-cliproj/guardium-deploy.git"

echo "New estap '${NAME_SUFFIX}' is provisioned. Now Waiting for the Load Balancer to come online."

# Based on article: https://stackoverflow.com/questions/35179410/how-to-wait-until-kubernetes-assigned-an-external-ip-to-a-loadbalancer-service

timeout 100s bash -c 'until oc get service/estap-guardium-estap-'${NAME_SUFFIX}'-lb --output=jsonpath='{.status.loadBalancer}' -n user1-bgd | grep "ingress"; do : ; done'

echo "LoadBalancer for the estap '${NAME_SUFFIX}' is ready. Here is the hostname:\n***"
oc get service/estap-guardium-estap-${NAME_SUFFIX}-lb --output=jsonpath='{.status.loadBalancer.ingress[0].hostname}' -n user1-bgd 
echo "\n***"