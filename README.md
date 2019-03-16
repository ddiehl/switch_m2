# switch_m2
There are some cases when you want to keep to separate folder of Maven M2 folders, when for instance you have work repositories or custom settings.xml for each one. you could indicate a different settings.xml while running maven command or on your IDE, but perhaps you don't even want to mix internal libraries with other executions. 

With that in mind this script was created, it basically create copies od .m2 folders and makes .m2 a symbolic link so every time you run the script it points the link to the desired m2. 

To