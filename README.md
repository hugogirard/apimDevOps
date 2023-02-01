# APIM DevOps

This github provide an example how to do DevOps with Github for Azure API Management.  

One good implementation is described [here](https://github.com/Azure/azure-api-management-devops-resource-kit)

This sample will provide another organization structure that you can use to implement DevOps when you have multiples **git** repositories.

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

Each teams that develop APIs will have their own dedicated Git repository.  Doing so they can only modify their own set of API and be independant of other teams.

This Git repository represent this kind of structure.  We use folder in this case but the opsTeam represent the Git related to the Ops Team, fibonnaciApi a dev team working on this api and weatherApi another API team.

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/folder.png?raw=true' />

Folder|Description
--- | --- |
.github/workflows | Contains all pipeline associate to each folder.
opsTeam | Contains the core ARM template and shared configuration for all APIM in the organization
fiboncciApi | Contains the source code of the Fibonacci API and the ARM template to configure the API in APIM.
weatherApi | Contains the source of the Weather API and the ARM template to configure the API in APIM.

## Github Actions

Here we used Github action but any CI/CD tool is the same purpose.

You have 6 pipelines.

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/actions.png?raw=true' />

Github Action | Description
--- | --- |
Deploy Azure APIM Core | This pipeline deploy all APIMS with global settings.  Should be managed by the OpsTeam.
Deploy Infra Fibonacci API | This pipeline deploy the infra (web app) for the Fibonacci API
Deploy Fibonacci API | This pipeline deploy the Fibonnaci API in Azure and configure it in APIM
Deploy Infra Weather API | This pipeline deploy the infra (web app) for the Weather API
Deploy Weather API | This pipelie deploy the Weather API in Azure and Configure it in APIM.
Destroy Azure Resources | This pipeline destroy all the resources created in this demo in Azure

The Github **Deploy Azure APIM Core** contains two [environments](https://docs.github.com/en/actions/reference/environments), the production one requiered an approver.

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


Be sure after to create two environment with those name

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/env.png?raw=true' />

In our case we put an approver for the **production** environment but this is up to you.

Now you can run the Deploy Azure APIM Core, depending if you added an approver for the production environment you will need to approve to create the resource in production.

Once this is done run the Github Action **Deploy Infra Fibonacci API** and **Deploy Infra Weather API**.  Once this is done, all web apps for both environment will be created.

Next you can deploy the APIs running **Deploy Fibonnaci API** and **Deploy Weather API**.

### Azure APIM DevOps Toolkit Creator

If you refer to our provided toolkit (first link in the README), you have a tool call the extractor.  This help you to extract the ARM template for all your APIM or only one specific API.  Is recommended to use this at the beginning but when you are familiar with the ARM template you shouldn't need to extrator anymore.  

Once you even gain more maturity I will recommend using a better tooling like [Bicep](https://github.com/Azure/bicep).

https://techcommunity.microsoft.com/t5/azure-developer-community-blog/automate-your-api-deployments-with-azure-api-management-and/ba-p/3682278