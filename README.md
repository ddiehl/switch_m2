# switch_m2
There are some cases when you want to keep to separate folder of Maven M2 folders, when for instance you have work repositories or custom settings.xml for each one. you could indicate a different settings.xml while running maven command or on your IDE, but perhaps you don't even want to mix internal libraries with other executions. 

With that in mind this script was created, it basically create copies od .m2 folders and makes .m2 a symbolic link so every time you run the script it points the link to the desired m2. 

To use this script download switch\_m2.sh and put it on your PATH, you can add a folder to your PATH.
every time you want to swtich m2 just type switch\_m2.sh, it will present you a list of m2 folder and you can select from that list. You can also call switch\_m2.sh \<\<name of m2\>\>.