FROM jenkins/jenkins:lts-alpine

COPY plugins.txt /plugins.txt

RUN /usr/local/bin/install-plugins.sh < /plugins.txt

COPY init.groovy.d/* /usr/share/jenkins/ref/init.groovy.d/

ENV JENKINS_USER admin.user

ENV JAVA_OPTS "-XX:+UnlockExperimentalVMOptions \
    -XX:+UseCGroupMemoryLimitForHeap \
    -XX:MaxRAMFraction=1 \
    -Djenkins.install.runSetupWizard=false \
    -Duser.timezone=America/New_York \
    -Dhudson.security.csrf.requestfield=Jenkins-Crumb \
    -Dpermissive-script-security.enabled=true"

USER jenkins
