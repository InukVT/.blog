---
title: Control MyQ Garages with HomeKit without the hub
slug: wip-control-myq-wi-fi-garages-for-cheap
date_published: 1970-01-01T00:00:00.000Z
date_updated: 2020-01-29T17:58:54.000Z
draft: true
---

	The HomeKit ecosystem is slowly and steadily growing, device manufacters are now adding add-on hubs to squeeze more money out of you to add HomeKit support. I don't know about you, but I don't want to pay $50 for functionality that can be done for free.

For this project you will need:

- A Raspberry Pi OR a Mac/PC 
- MyQ Wi-Fi Enabled Opener(s) 
- A HomeKit HomeHub (iPad, Apple TV 4+, HomePod)
- Homebridge [Homebridge](homebridge.io)

When using the MyQ app for the first time you get excited as it asks for permission to access your home data thinking you can add your garages straight out of the box, which you can't unless you buy their hub. Thankfully a developer known as c[aseywebdev](https://github.com/caseywebdev) made a homebridge plugin for this exact reason. If you don't have homebridge installed, you can use the official guide [here](https://github.com/nfarina/homebridge/blob/master/README.md). This plugin is hosted on GitHub [here](https://github.com/caseywebdev/homebridge-chamberlain), and is published via npm. 

While the plugin is named after Chamberlain, other MyQ garage doors are compatible. After this it's fairly easy, you just need to update your config.json file. It's stored in your homebridge folder directory to get there do cd .homebridge/ For this plugin you need your devide ID's, when you run the plugin for the first time, it will give you your deviceID's. Paste the example below to generate your deviceID's, then restart HomeBridge.

# ID Generator config:

    {
    	"bridge": {
    		"name": "Garage Bridge",
    		"username": "CC:22:3D:E3:CE:21",
    		"port": 51822,
    		"pin": "031-45-154"
    	},
    
    	"ports": {
    		"start": 52100,
    		"end": 52150,
    		"comment": "This section is used to control the range of ports that separate accessory (like camera or television) should be bind to."
    	},
    	"accessories": [{
    		"accessory": "Chamberlain",
    		"name": "Garage Door",
    		"username": "your mychamberlain.com email",
    		"password": "your mychamberlain.com password"
    	}]
    }
    

Now that you have your device ID's enter them into your config file. The first example is if you have one garage door, the second being 2 garage doors, and finally the 3rd being 3 garage doors. While there is no limit to how many garage doors you can add, I don't know many homes having 4 garage doors. If you do need 4 or more garage doors, PM me on [Twitter](Https://Twitter.com/iRayanKhan).

# One Door:

    {
    	"bridge": {
    		"name": "Garage Bridge",
    		"username": "CC:22:3D:E3:CE:21",
    		"port": 51822,
    		"pin": "031-45-154"
    	},
    
    	"ports": {
    		"start": 52100,
    		"end": 52150,
    		"comment": "This section is used to control the range of ports that separate accessory (like camera or television) should be bind to."
    	},
    	"accessories": [{
    		"accessory": "Chamberlain",
    		"name": "Garage Door",
    		"username": "your mychamberlain.com email",
    		"password": "your mychamberlain.com password",
    		"deviceId": "xxx"
    	}]
    }
    

# Two Doors:

    {
    	"bridge": {
    		"name": "Garage Bridge",
    		"username": "CC:22:3D:E3:CE:21",
    		"port": 51822,
    		"pin": "031-45-154"
    	},
    
    	"ports": {
    		"start": 52100,
    		"end": 52150,
    		"comment": "This section is used to control the range of ports that separate accessory (like camera or television) should be bind to."
    	},
    	"accessories": [{
    			"accessory": "Chamberlain",
    			"name": "Garage Door 1",
    			"username": "your mychamberlain.com email",
    			"password": "your mychamberlain.com password",
    			"deviceId": "xxx"
    		},
    		{
    			"accessory": "Chamberlain",
    			"name": "Garage Door 2",
    			"username": "your mychamberlain.com email",
    			"password": "your mychamberlain.com password",
    			"deviceId": "xxx"
    		}
    	]
    }
    

# Three Doors:

    {
    	"bridge": {
    		"name": "Garage Bridge",
    		"username": "CC:22:3D:E3:CE:21",
    		"port": 51822,
    		"pin": "031-45-154"
    	},
    
    	"ports": {
    		"start": 52100,
    		"end": 52150,
    		"comment": "This section is used to control the range of ports that separate accessory (like camera or television) should be bind to."
    	},
    	"accessories": [{
    			"accessory": "Chamberlain",
    			"name": "Garage Door",
    			"username": "your mychamberlain.com email",
    			"password": "your mychamberlain.com password",
    			"deviceId": "xxx"
    		},
    		{
    			"accessory": "Chamberlain",
    			"name": "Garage Door 2",
    			"username": "your mychamberlain.com email",
    			"password": "your mychamberlain.com password",
    			"deviceId": "xxx"
    		},
    		{
    			"accessory": "Chamberlain",
    			"name": "Garage Door 3",
    			"username": "your mychamberlain.com email",
    			"password": "your mychamberlain.com password",
    			"deviceId": "xxx"
    		}
    	]
    }
    
    

That's it, you just saved some money. If you run into any issues, open an issue in the GitHub repo and I will get back to you within 48 hours. Enjoy your Siri powered garages!
