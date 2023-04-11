# Simple WebID Federation Project

This project showcases on we can use federated identities to access a private buckets S3 content for a serverless appplication. 

Cognito has a limit of 5k users and the use of federated identities allows for large organizations or apps to use AWS services. 

## Architecture Diagram

![FedWebIDProject drawio](https://user-images.githubusercontent.com/12003721/230792962-269a51b5-439f-4cc8-a9f8-cb18b4b8c943.png)

## Infrastructure/Technology Used
* CloudFront
* S3 
* Cognito
* Google API

# Terraform
The root main.tf script will produce reproduce the base infrastructure. S3 buckets, S3 files, S3 policies, etc. 

Code updates, Cognito, Google API Project, code updates (HTML and JS) will have to be done via click ops :(

## Google API Setup & Cognito

Google API Summary Steps:
* https://console.developers.google.com/apis/credentials
* Create a new project and ensure that it is for external users
* Go to credentials, create credentials and choose OAUTH client ID, & app type = 'Web Application'
* Copy Client ID 
* Update client id field in the index.html and reupload to S3 ```data-client_id="857529441615m3dl5hnhfmg9bi4tpd6lfhg7gjid01s.apps.googleusercontent.com" ```

Cognito Setup Summary Steps:
* Go to AWS Cognito and select Federated Identities
* Create new identity pool
* Choose federated identities, new identity pool, enter name
* Auth Providers = Google+, and enter Google Client ID from before
* Create permissions for AuthN and UnAuthN identities

Update JS File and reupload to the appbucket 
* Update Cognito ID in scripts.js ```IdentityPoolId: 'REPLACE_ME_COGNITO_IDENTITY_POOL_ID',```
* Update Bucket info in scripts.js ```Bucket: "REPLACE_ME_NAME_OF_PATCHES_PRIVATE_BUCKET" ```

## Lessons Learned
This is my first time using Terraform modules successfully! In my prior projects, my terraform code was many hundreds of lines long. With modules, it help's with the aesthetic appeal of the code and helps logically organize the code. 

Originally I wanted to create the entire infrastruture but ran into the challenge of incorporating Google API creation for the federated ID. To create the cognito infra, the google API client ID is required. I will probably revisit this and explore how I can create the entire infrastructure programatically. 

I also learned how to use Google as an identity provider. 
