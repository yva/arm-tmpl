<<<<<<< HEAD
# ARM templates for YVA azure deploy

[![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/)

## Template variables  

* **name**: prefix of azure generated url 4 your Yva instance, for example *aztmp.westeurope.cloudapp.azure.com*, **name** is *aztmp*
* **yvalogin** & **yvapass**: credentials you recived from our sell department
* **securestring**: password you provide 4 access to admin page 

Please visit [yva.ai](https://yva.ai) for details
=======
# ARM templates for Azure deployments

Welcome to the GitHub repository for Yva.ai's ARM templates for Azure deployments. All of the templates in this repository have been developed by Yva.ai engineers.

[![Deploy to Azure](https://azuredeploy.net/deploybutton.svg)](https://azuredeploy.net/)

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
>>>>>>> 1a3dc446d638b80b0c3df1e0453517584cac3fb9
