FROM zhiqzhao/ubuntu_weblogic1036_domain

ENV INSPECTIT_VERSION 1.7.8.91
ENV INSPECTIT_AGENT_HOME /opt/agent

# prepare the needed libs
RUN apt-get update && apt-get install -y wget unzip zip \	
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# download agent and prepare
RUN wget https://github.com/inspectIT/inspectIT/releases/download/${INSPECTIT_VERSION}/inspectit-agent-java6-${INSPECTIT_VERSION}.zip -q \
 && unzip inspectit-agent-java6-${INSPECTIT_VERSION}.zip -d /opt \
 && rm -f inspectit-agent-java6-${INSPECTIT_VERSION}.zip

RUN sed -i "97i INSPECTIT_JAVA_OPTS=\"-javaagent:${INSPECTIT_AGENT_HOME}/inspectit-agent.jar -Dinspectit.repository=_CMR_ADDR_:_CMR_PORT_ -Dinspectit.agent.name=_AGENT_NAME_\"" /root/Oracle/Middleware/user_projects/domains/base_domain/bin/startWebLogic.sh \
 && sed -i "98i JAVA_OPTIONS=\"\${INSPECTIT_JAVA_OPTS} \${JAVA_OPTIONS}\"" /root/Oracle/Middleware/user_projects/domains/base_domain/bin/startWebLogic.sh

# delete the javax.xml.parsers.SAXParserFactory property from the services
# this ensures inspectIT is started correctly
RUN zip -d /root/Oracle/Middleware/wlserver_10.3/server/lib/weblogic.jar /META-INF/services/javax.xml.parsers.SAXParserFactory

# copy start script
COPY run-with-inspectit.sh /run-with-inspectit.sh

CMD /run-with-inspectit.sh
