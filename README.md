# sealbeachbaby 
Step 1: Please watch an integral part of my project: "https://www.youtube.com/watch?v=SFLSOIufuhM" It is only 4 minutes 8 seconds, but will ensure you never forget your keys.



**Along the way keys are required ssh, and otherwise. You will can configure you image by simply typing
"AWS Configure" which will prompt you for an AWS Access Key/Secret Key which is assocaited with an 
IAM policy that has all of the privileges associated with that key. i.e. ecr access, ecs access, ec2 access etc.Also, ensure you 
don't have any SG's configured to block access to 8080,22,3000**



Step 1) wget blah blah

At this point you should have multiple terraform files cloned to your local machine or virtual machine. 
Everything you need is in one of these terraform files.

A brief aside: Honey where are your keys? Grab your keys, you can't go anywhere without them. **MAJOR KEY ALERT**

Go ahead and smash that terraform apply...with your keys don't forget the keys.

2)ssh to your jenkins server we just created

ssh -i [name of your keys i.e. DJ khaled] username@XX.XXX.XXX.XX
Example: ssh -i mykey ubuntu@11.111.111.11 **Major KEY ALERT**
trust the host and connect

*still on Jenkins server*
a) sudo -s
b) CAT the pwd to jenkins server by navigating to /var/lib/jenkins/secrets/initialadminpassword
 cmd: cat /var/lib/jenkins/secrets/initialadminpassword

create your jenkins user when prompted by navigating to the jenkins ip over 8080

i.e.If it is on 11.111.111.11 then navigate to  11.111.111.11:8080
**Once you are in Jenkins, select "Manage Jenkins" and ensure you have all of the proper plug-ins enabled**

3) Create a new proyecto in Jenkins 

4)Add source code from my github url
	a)scroll down under the "Build" heading of the URL. Select "execute shell" which will execute the shell script.
	b) in the command it should be something like....
		"docker -t ecr_URL/surfline:{Git_Commit} . "
		eval "$(aws ecr get-login --region -us-east-1)"
		"docker push ecr_URL/surfline:{Git_Commit}
	c)SAVE.
	c)login to the jenkins box and ssh -i mykey ubuntu@jenkinsIP  **MAJOR KEY ALERT**
		i.sudo su-jenkins and run AWS Configure and enter proper AWS ACcess and Secret Keys **MAJOR KEY ALERT**
4)Create another new freestyle proyecto
	a) same as 4(b) except the command will be different
		cd surfline-project
		cd sealbeachbaby (I'm from seal beach, idk why the baby is in there terraform was probably driving me crazy)
		touch mykey
		touch mykey.pub
		-terraform apply -target aws_ecs_service.surfline-service -var Surfline_SERVICE_ENABLE="1" -var surfline_version = ${surfline_version}
	SAVE

5) run configure remote state script back in the shell

6)Navigate back to your first proyecto you created and navigate to "Build Environment"

	a) On post build actions type in the name of second project you created
	b)Select trigger when build is "stable"
	c)add a predefined paramater of SURFLINE_VERSION: ${GIT_COMMIT}
	d)SAVE

7) Select Build now.

8) you should see all of your resources being built. It should be pulling your Docker image and you should see the steps being carried out as seen in our Dockerfile e.g. Node, npm
install, pushing the image to ecr. Go grab coffee. You should also see it is triggering your second project at the tail end.

9) If you navigate back to your project you will see that the build has been triggered which mainly includes your ecs service and it will spit out your elb DNS id. copy and paste the DNS 
into the URL and you should see "Hello World" nodejs app


cheers
