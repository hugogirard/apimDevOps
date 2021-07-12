# Introduction

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

You have 4 pipelines but in fact 3 are important.

<img src='https://raw.githubusercontent.com/hugogirard/apimDevOps/main/images/actions.png?raw=true' />
