pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: all-labs
    image: bryandollery/terraform-packer-aws-alpine 
    command: 
    - bash
    tty: true
"""
    }
  }
  environment {
    //CREDS = credentials('phi_docker_creds')
    //AWS_ACCESS_KEY_ID = "${CREDS_USR}"
    //AWS_SECRET_ACCESS_KEY = "${CREDS_PSW}"
    //OWNER = 'phi'
    //PROJECT_NAME = 'jenkins'
  }
  stages {
      stage("build") {
          steps {
              container('all-labs') {
                  sh 'make elf && make pro-graf'
              }
          }
      }
  }

}

