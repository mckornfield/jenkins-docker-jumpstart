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

# Install Android SDK
ENV ANDROID_SDK_VERSION 24.4.1

ENV ANDROID_SDK_ZIP android-sdk_r$ANDROID_SDK_VERSION-linux.tgz
ENV ANDROID_SDK_ZIP_URL https://dl.google.com/android/$ANDROID_SDK_ZIP
ENV ANDROID_HOME /opt/android-sdk-linux

ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools

ADD $ANDROID_SDK_ZIP_URL /opt/
USER root
RUN tar xzvf opt/$ANDROID_SDK_ZIP -C /opt/ && \
  rm /opt/$ANDROID_SDK_ZIP && \
  echo "y" | android update sdk -u -a --filter platform-tools,android-25,build-tools-26.0.2 && \
  chmod -R 777 $ANDROID_HOME && \
  chown -R jenkins:jenkins $ANDROID_HOME

USER jenkins
