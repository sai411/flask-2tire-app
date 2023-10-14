pipeline{

    agent  any

    environment {
        docker_image = "sai411/flask_img_project:${env.BUILD_NUMBER}"
        docker_image_latest = "sai411/flask_img_project:latest"
    }
  
    stages{
    
       stage('build docker file'){
     
             steps{
                sh "ls -lrt"
                sh "docker build -f Dockerfile -t ${docker_image} ."
                sh "docker tag ${docker_image} ${docker_image_latest}"
                docker.withRegistry('', 'docker-cred'){
                   sh "docker push ${docker_image_latest}"
                   sh "docker push ${docker_image}"
                }
                

             }


       }
     stage('deploy'){

        steps{
            sh "docker network rm my-network"
            sh "docker network create my-network"
            sh "docker stop mysql && docker rm mysql"
            sh "docker run -dit --name=mysql -p 3306:3306 --network my-network -e 'MYSQL_ROOT_PASSWORD=1234' -e 'MYSQL_DATABASE=mydb' -e 'MYSQL_USER=admin' -e 'MYSQL_PASSWORD=admin' -v ./message.sql:/docker-entrypoint-initdb.d/message.sql mysql"
            sh "docker stop flask-app && docker rm flask-app"
            sh "docker run -dit --name=flask_app -p 5000:5000 -e 'MYSQL_HOST=mysql' -e 'MYSQL_USER=admin' -e 'MYSQL_PASSWORD=admin' -e 'MYSQL_DB=mydb' --network my-network flask_app:v1"
        }

     }

       }
   

    }
