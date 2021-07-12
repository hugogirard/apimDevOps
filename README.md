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

This Git repository represent this kind of structure.

