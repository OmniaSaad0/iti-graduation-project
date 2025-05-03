pipeline {
    agent { label 'kube-agent' }

    triggers {
        githubPush()  // This triggers the build on git push
    }

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = 'test'
        AWS_ACCOUNT_ID = credentials('aws-account-id')
        URL_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        IMAGE_TAG = "41.${env.BUILD_NUMBER}"
        FULL_IMAGE = "${URL_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}"

        // SONAR_SCANNER_HOME = tool 'sonar-scanner';

    }

    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Ma-Eltohamy/jenkins_nodejs_gp.git'
            }
        }

        //  stage('SAST - SonarQube') {
        //     steps {
                
        //         timeout(time: 60, unit: 'SECONDS') {
        //             withSonarQubeEnv('sonarqube') {
                
        //                 sh '''
        //                     $SONAR_SCANNER_HOME/bin/sonar-scanner \
        //                         -Dsonar.projectKey=node-app \
        //                         -Dsonar.sources=app.js \
                                
        //                 '''
        //             }
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // } 

        // stage('Trivy Pre-Scan') {
        //     steps {
        //         container('kaivy') {
        //             script {
        //                 // Fail pipeline if last image has CRITICAL vulns
        //                 sh """
        //                 trivy image ${URL_REGISTRY}/${ECR_REPO}:latest \
        //                 --severity CRITICAL \
        //                 --exit-code 0 \
        //                 --quiet || echo 'Note: latest image may have CRITICALs'
        //                 """
        //             }
        //         }
        //     }
        // }

        // stage('Kaniko build & tag (staging only)') {
        //     steps {
        //         container('kaivy') {
        //             script {
        //                 // Build an output.tar image to make trivy then check it
        //                 sh """
        //                 /kaniko/executor \
        //                   --context=git://github.com/Ma-Eltohamy/jenkins_nodejs_gp.git#rds_redis \
        //                   --destination=${FULL_IMAGE} \
        //                   --dockerfile=dockerfile \
        //                   --no-push \
        //                   --tar-path=/workspace/output.tar
        //                 """
        //             }
        //         }
        //     }
        // }

        // stage('Trivy Scan tarball image') {
        //     steps {
        //         container('kaivy') {
        //             script {
        //                 sh """
        //                 trivy image --input /workspace/output.tar \
        //                 --severity CRITICAL \
        //                 --exit-code 1 \
        //                 --format json \
        //                 -o trivy-result.json
        //                 """
        //             }
        //         }
        //     }
        // }

        stage('Push to ECR (only if passed scan)') {
            steps {
                container('kaivy') {
                    script {
                        // Push the image if it only passed from trivy
                        sh """
                        /kaniko/executor \
                          --context=git://github.com/Ma-Eltohamy/jenkins_nodejs_gp.git#master \
                          --destination=${FULL_IMAGE} \
                          --dockerfile=dockerfile
                        """
                    }
                }
            }
        }
    }
}
