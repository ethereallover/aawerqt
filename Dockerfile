FROM 103.160.122.246/operator/openjdk8-sky3:hengsheng
ENV DIST_NAME=aawerqt-packagegroup-package\
			APP_VERSION=0.0.1-SNAPSHOT
COPY  ./aawerqt-packagegroup/aawerqt-packagegroup-package/target/"$DIST_NAME-$APP_VERSION.war" /home/gaps/"$DIST_NAME.war"
EXPOSE 8081
RUN chown -R gaps.gaps /home/gaps/"$DIST_NAME.war"
USER gaps
ENTRYPOINT java -javaagent:/skywalking-agent/skywalking-agent.jar \
		-XX:+PrintFlagsFinal -XX:+UnlockExperimentalVMOptions 	-XX:+UseCGroupMemoryLimitForHeap $JAVA_OPTS \
		-Dgaps.microservice.registryAddr=$EUREKA_URL 	-Dgaps.application.name=$SW_AGENT_NAME -jar /home/gaps/$DIST_NAME.war