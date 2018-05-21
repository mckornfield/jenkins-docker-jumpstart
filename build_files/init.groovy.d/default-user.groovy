#!groovy

import jenkins.model.*
import hudson.security.*

def env = System.getenv()
def instance = Jenkins.getInstance()

println "--> creating local user '" + env.JENKINS_USER + "'"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)

file = new File("/secrets/jenkins_admin_password")
password = file.text.trim()

hudsonRealm.createAccount(env.JENKINS_USER,password)
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
stategy.setAllowAnonymousRead(false);
instance.setAuthorizationStrategy(strategy)
instance.save()
