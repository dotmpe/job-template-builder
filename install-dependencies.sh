#!/usr/bin/env bash

# JTB dep installer for travis
# Id: jtb/0.0.2-master install-dependencies.sh

source ./util.sh

test -n "$JJB_HOME" || {
    # default checkout dir at travis
    JJB_HOME=$HOME/build/jjb
}

install_jjb()
{

  test -d "$JJB_HOME" || {

      log "Cloning JJB.."
      git clone https://git.openstack.org/openstack-infra/jenkins-job-builder $JJB_HOME \
        || err "Error cloning to $JJB_HOME" 1

      log "Installing JJB.."
      pushd $JJB_HOME

      # Install into ~/..user-packages
      python setup.py install --user \
        && log "JJB install complete" \
        || err "Error during JJB installation" 1

      popd
  }

  jenkins-jobs --version && {
    log "JJB install OK"
  } || {
    err "JJB installation invalid" 1
  }
}

