NAME_SUFFIX=test-05
GUARDIUM_HOST=20.246.81.102
DB_HOST=sqlserver02.database.windows.net
DB_PORT=1433
DB_TYPE=mssql


#{NAME_SUFFIX}
#{GUARDIUM_HOST}
#{DB_HOST}
#{DB_PORT}
#{DB_TYPE}

TMPL_FILE=./guardium-etap-template.values.yaml
#DEST_FILE=./estap/gitops/ocp-demo/guardium-estap-${NAME_SUFFIX}/values.yaml
#mkdir ./estap/gitops/ocp-demo/guardium-estap-${NAME_SUFFIX}
sed -e 's/{NAME_SUFFIX}/'$NAME_SUFFIX'/;s/{GUARDIUM_HOST}/'$GUARDIUM_HOST'/;s/{DB_HOST}/'$DB_HOST'/;s/{DB_PORT}/'$DB_PORT'/;s/{DB_TYPE}/'$DB_TYPE'/' ${TMPL_FILE}
git add .
git commit -m "Add new vallues.yaml for the guardium deployment '${NAME_SUFFIX}'"
git push
