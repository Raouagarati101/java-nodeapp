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
   
	stage('Deploy to k8s'){
		steps{ 
			sh "chmod +x changeTag.sh" 
			sh "./changeTag.sh ${DOCKER_TAG}" 
			sshagent(['kubernetes-master']) {
				sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml root@192.168.1.12" 
			 script{
				 try{ 
					 sh "ssh root@192.168.1.12 kubectl apply-f ." 
				 }catch (error){ 
					 sh "ssh root@192.168.1.12 kubectl create-f ." 
				 }
			 }
			}
		}
	}
}
}
def getDockerTag() {
		def tag = sh script: 'git rev-parse HEAD', returnStdout: true
		return tag 
	}
