# set accelerator home
cd ../
ACCELERATOR_HOME=$(pwd)
echo "Accelerator home is: ${ACCELERATOR_HOME}"

# set product home
cd ../
WSO2_OB_IS_HOME=$(pwd)
echo "Product home is: ${WSO2_OB_IS_HOME}"

ISKM_CONNECTOR=wso2is-extensions-1.2.10

wget https://apim.docs.wso2.com/en/4.0.0/assets/attachments/administer/${ISKM_CONNECTOR}.zip
unzip "${ISKM_CONNECTOR}.zip"
cd wso2is-extensions-1.2.10

ISKM_CONNECTOR_FOLDER=$(pwd)

cp ${ISKM_CONNECTOR_FOLDER}/dropins/* ${WSO2_OB_IS_HOME}/repository/components/dropins/
cp ${ISKM_CONNECTOR_FOLDER}/webapps/* ${WSO2_OB_IS_HOME}/repository/deployment/server/webapps
