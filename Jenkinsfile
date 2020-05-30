pipeline {
    agent any
    environment{
        DOCKER_TAG=getDockerTag()
       
    }
    stages{
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t raouagara/java-nodeapp:${DOCKER_TAG}"
            }
        }
	     stage('Docker push image'){
            steps{
		    withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'DOCKER_HUB_CREDENTIALS')]) {
			    sh "docker login -u raouagara -p ${DOCKER_HUB_CREDENTIALS}" 
			    sh "docker push raouagara/java-nodeapp:${DOCKER_TAG}"
    }
	    }
	     }
    }
}
	def getDockerTag(){
		def tag = sh script: 'git rev-parse HEAD', returnStdout: true
		return tag }
