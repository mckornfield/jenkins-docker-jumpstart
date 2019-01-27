FROM jenkins/jenkins:lts

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

# Set Android properties and download zip
ENV ANDROID_SDK_VERSION 25.2.5

ENV ANDROID_SDK_ZIP android-sdk-tools.zip
ENV ANDROID_SDK_ZIP_URL https://dl.google.com/android/repository/tools_r$ANDROID_SDK_VERSION-linux.zip
ENV ANDROID_HOME /opt/android-sdk-linux

ENV PATH $PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

USER root

# Install android
RUN wget $ANDROID_SDK_ZIP_URL -O /tmp/$ANDROID_SDK_ZIP && \
  mkdir -p $ANDROID_HOME && \
  unzip -q /tmp/$ANDROID_SDK_ZIP -d $ANDROID_HOME && \
  rm /tmp/$ANDROID_SDK_ZIP

RUN mkdir -p ~/.android && touch ~/.android/repositories.cfg && \
  echo y | sdkmanager tools && \
  sdkmanager platform-tools && \
  sdkmanager "platforms;android-25" && \
  sdkmanager "build-tools;27.0.3" && \
  sdkmanager "extras;google;m2repository" && \
  sdkmanager "extras;android;m2repository" && \
  echo y | sdkmanager --licenses && \
  chmod -R 777 $ANDROID_HOME && \
  chown -R jenkins:jenkins $ANDROID_HOME

#RUN apk --no-cache add ca-certificates wget && \
#  wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
#  wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk && \
#  apk add glibc-2.27-r0.apk && \
#  rm -rf /var/cache/apk/*
#
USER jenkins
