# ARM scripts 4 yva azure deploy

*doesn't work 4 a moment, it's wait 4 github publish*
[![Deploy][deplogo]](https://azuredeploy.net?repository=https://dl.yva.ai/public/arm/branches/params_/yva.json)

[deplogo]: http://azuredeploy.net/deploybutton.png

# Files

## yva.json 
  * the one json to rule them all
  * it holds structures with params and call its dependencies

## vnet.json 
  * virual network, subnets, URL, access rules

## front.json  
  * single node with ssh & http & https ports opened

## host.json 
  * simple node w/o direct access from internet
## exec.json 
  * VM for scale part of applicatin
