# APIM DevOps

This github provides an example how to do DevOps with Github for Azure API Management.  

Keep in mind, there is none one solution only to achieve this, this is one example using Bicep.  The same can be accomplished with Terraform or other Open Source tools provided by Microsoft.

DevOps can be done in multiple ways, Microsoft provides some recommendation [here](https://learn.microsoft.com/en-us/azure/api-management/devops-api-development-templates).

The proper flow of API in a DevOps world will be this one below.

![devops](https://learn.microsoft.com/en-us/azure/api-management/media/devops-api-development-templates/api-management-cicd-flow.png)

You create your API using OpenAPI specification, someone review your APIs and once everything is approved you publish it to production.

This sample will provide an organization structure that you can use to implement DevOps when you have multiples **git** repositories.

Suppose you have an organization with this structure.

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/gitStructure.png?raw=true' />

In this diagram you have the **OpsTeam** that have their own Git Repository.  The purpose of the OpsTeam is to configure all APIM used in the organization.

This can include all the shared configuration in the organization for APIM like:

<ul>
  <li>Named Values</li>
  <li>Backend Service</li>
  <li>Products</li>
  <li>Global Policy</li>
</ul>

Each team that develop APIs will have their own dedicated Git repository.  Doing so, they can only modify their own set of APIs and be independent of other teams.

This Git repository represents this kind of structure.  We use folder in this case (in real world scenario you will have multiple Git). In this case we have 3 folder:

<ul>
  <li>opsTeam (Ops Cloud Team)</li>
  <li>fibonacciApi (The dev team of the fibonacci API)</li>
  <li>weatherApi (The dev team of the weather API) </li>
</ul>

Those 3 folders represent like 3 different git repository.

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/folder.png?raw=true' />

Folder|Description
--- | --- |
.github/workflows | Contains all pipeline associates to each folder.
opsTeam | Contains the core ARM template and shared configuration for all APIM in the organization
fiboncciApi | Contains the source code of the Fibonacci API and the ARM template to configure the API in APIM.
weatherApi | Contains the source of the Weather API and the ARM template to configure the API in APIM.

## Github Actions

Here we used Github action but any CI/CD tool is the same purpose.

You have 6 pipelines.

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/actions.png?raw=true' />

Github Action | Description
--- | --- |
Deploy Azure APIM Core | This pipeline deploys all APIMS with global settings.  Should be managed by the OpsTeam.
Deploy Infra Fibonacci API | This pipeline deploys the infra (web app) for the Fibonacci API
Deploy Fibonacci API | This pipeline deploys the Fibonnaci API in Azure and configure it in APIM
Deploy Infra Weather API | This pipeline deploys the infra (web app) for the Weather API
Deploy Weather API | This pipelie deploys the Weather API in Azure and Configure it in APIM.
Destroy Azure Resources | This pipeline destroys all the resources created in this demo in Azure

The Github **Deploy Azure APIM Core** contains two [environments](https://docs.github.com/en/actions/reference/environments), the production one required an approver.

## How to use this Github

Fork this Github repository

Next you will need to create 6 Github Secrets

Secret | Description
--- | --- |
AZURE_CREDENTIALS | This secret is the credential of the Service Principal used in the Github Action.  It's needed when running the Azure Login.  Refer here for more information https://github.com/marketplace/actions/azure-login#configure-deployment-credentials
PA_TOKEN | Needed to run the Github Action that create secrets, for more information read https://github.com/gliech/create-github-secret-action.
PUBLISHER_NAME | The name of the publisher of the APIM
PUPLISHER_EMAIL | The email of the publisher
SUBSCRIPTION_ID | The subscription ID where is deployed all the Azure Resources
PA_TOKEN | Needed to write Github Secrets after the infra pipeline is done executed.  For more information read https://github.com/gliech/create-github-secret-action#pa_token

Be sure after to create two environments with those names

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/env.png?raw=true' />

But an approver for the **PROD** environment.

Now you can run the Deploy Azure APIM Core, will need to approve to create the resource in production.

Once this is done run the Github Action **Deploy Infra Fibonacci API** and **Deploy Infra Weather API**.  Once this is done, all web apps for both environments will be created.

Next you can deploy the APIs running **Deploy Fibonnaci API** and **Deploy Weather API**.

### Resources


Here a great [article](https://techcommunity.microsoft.com/t5/azure-developer-community-blog/automate-your-api-deployments-with-azure-api-management-and/ba-p/3682278) related to DevOps with Azure Api Management.
