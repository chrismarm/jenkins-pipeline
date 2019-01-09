# Jenkins pipeline to build a Java app

We are going to create a pipeline to be run in a Jenkins master container that deploys the built app onto a production server in another container. This is made by executing docker-compose from the root docker-compose .yml file.
- Jenkins container (defined in `jenkins-master/Dockerfile`) is based on a Jenkins image and installs Docker and docker-compose on it, because we are going to run `Maven` and `Java` containers on it. 
- Production server container (defined in `production-server/Dockerfile`) is based on a Ubuntu image and installs Docker and docker-compose. Besides, it adds an open-ssh server and copies the ssh public key created in Jenkins master container in order to enable communication between Jenkins and the production server.

### Pipeline stages

Defined in the `Jenkinsfile` we can find the different stages for this pipeline. Tha goal is compiling a Java app from code stored in GitHub every time there is a change in the code. After compiling and running some tests, a Docker image is created with the app, pushed to Docker Hub registry and deployed to the production server.

###### Build
 
 A Jenkins pipeline project must be created in advance, setting the definition from a Git repository and specifying the URL and credentials for the GitHub repo and the path inside the project for the Jenkinsfile. This will start the pipeline every time a change is detected in that project/repository.
 
 In addition, in the Jenkinsfile we will run 2 scripts for this stage. 
 
 - The first of them (mvn.sh) receives a few parameters with the desired Maven commands, in this case 'clean package'. This script runs a Docker Maven container with 2 volumes (.m2 repo and the java app root folder), specifying the app folder as the working directory and running 'mvn clean package'. This will create a jar file with the app in the second volume.
 - The second one (build.sh) runs `docker-compose build` from a Java image and copies the created jar after the execution of the previous script.
 
As a post-action, we will archive the jar by the Jenkinsfile directive `archiveArtifacts` in case of a successful build.

###### Test

In this stage, we will simply run a similar script that runs a Docker container from Maven image with the command 'mvn test' (that runs the tests in app/src/test folder) and adds a `Surefire` report by the Jenkinsfile directive `junit`

###### Push

The script for this stage logs in to DockerHub with credentials already defined in Jenkins and retrieved in Jenkinsfile. After login, it tags and pushes the previously created image to DockerHub.

###### Deploy

The script for this stage writes a file with the credentials to login to DockerHub and the name/tag for the app image. Then copies by `scp` command this file to the production server together with a docker-compose.yml and a script to be executed in the production server by ssh. This script, when executed in the production server, reads the data (credentials and image information) in the copied file, logs in to DockerHub and runs docker-compose to pull the previously uploaded image and run the container.

### Future improvements

- Execute in a slave node the steps that are now executed in the master node (build, test and push)
- All the stages are currently performed with bash scripts that, among other things, run Docker containers. It would be interesting that they were executed with `Ansible` playbooks.


