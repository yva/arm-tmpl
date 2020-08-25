# ARM templates for Azure deployments

Welcome to the GitHub repository for Yva.ai's ARM templates for Azure deployments. All of the templates in this repository have been developed by Yva.ai engineers.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fyva%2Farm%2Fmaster%2Fazuredeploy.json" target="_blank"><img src="https://azuredeploy.net/deploybutton.svg"/></a>

## Parameters

The ARM template accepts the parameters listed below.

Name | Description
--- | ---
name | Prefix used by Azure to generate the URL gateway. For example, if you specify _yvaexample_, the following URL _yvaexample_.westeurope.cloudapp.azure.com will be created after deployment.
yvalogin | Login for deployment. Must be provided to you by an employee or partner of Yva.ai.
yvapass | Password for deployment. Must be provided to you by an employee or partner of Yva.ai.
securestring | The password that will be used to access the admin panel after deployment.

## Support

Please contact us at [support@yva.ai](mailto:support@yva.ai).


## Disclaimer

Any use, distribution or reproduction of this code from the current repository by unintended users, is not authorized and may be unlawful
