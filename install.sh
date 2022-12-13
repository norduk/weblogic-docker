echo "Generating silent xml..."
 
BEA_HOME="/opt/hcfb/weblogic/Oracle/Middleware/"
LOCAL_JVMS="/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.261-2.6.22.2.el7_8.x86_64"
WLS_DIR="${BEA_HOME}wlserver_10.3"
OCP_DIR="${BEA_HOME}coherence_3.7"
 
JVER=`echo $LOCAL_JVMS | awk -F '/' '{print $4}'`
 
AP_PORT=("7001")
AS_PORT=("7002")
 

SERVER=("IBS-RT")
DOMAIN=("RT")
MACHINE=("UNIX-6885")
 

XML="<?xml version=\"1.0\" encoding=\"UTF-8\"?><bea-installer><input-fields><data-value name=\"BEAHOME\" value=\"${BEA_HOME}\" /><data-value name=\"WLS_INSTALL_DIR\" value=\"${WLS_DIR}\" /><data-value name=\"OCP_INSTALL_DIR\" value=\"${OCP_DIR}\" /><data-value name=\"OCM_SUPPORT_EMAIL\" value=\"no\" /><data-value name=\"OCM_SUPPORT_PASSWORD\" value=\"no\" /><data-value name=\"COMPONENT_PATHS\" value=\"WebLogic Server/Core Application Server|WebLogic Server/Administration Console|Oracle Coherence/Coherence Product Files|WebLogic Server/Configuration Wizard and Upgrade Framework|WebLogic Server/Web 2.0 HTTP Pub-Sub Server|WebLogic Server/WebLogic SCA|WebLogic Server/WebLogic JDBC Drivers|WebLogic Server/Third Party JDBC Drivers|WebLogic Server/WebLogic Server Clients|WebLogic Server/WebLogic Web Server Plugins|WebLogic Server/UDDI and Xquery Support\" /><data-value name=\"LOCAL_JVMS\" value=\"$LOCAL_JVMS\"/></input-fields></bea-installer>"
 
echo $XML > ./silent.xml
 
if [ -f "./silent.xml" ]; then
    echo "Silent xml generated!"
else
    echo "Error! Silent xml not generated!"
    exit 1
fi
 
echo "Installing WebLogic..."
 
java -jar /opt/hcfb/weblogic/wls1036_generic.jar -silent_xml=./silent.xml -mode=silent -silent_log=./silent.log >> ./trace.log
 
if [ $? -eq 0 ]
then
    echo "WebLogic Installed!"
else
    echo "Error! WebLogic not installed!"
    exit 1
fi