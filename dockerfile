# THIS DOCKER FILE WAS DEVELOPED BY ASSISTANZ NETWORKS

# SPECIFY THE CONTAINER IMAGE
FROM microsoft/windowsservercore

# COPY THE TOMEE INSTALLATION FILES INTO THE CONTAINER
ADD ./setup c:/source

RUN powershell.exe -command \

# INSTALLING JAVA JRE
./source/jre.cmd; \

# INSTALLING JAVA JDK
./source/jdk.cmd; \

# COPYING TOMEE SETUP FILES TO C Drive
Copy-Item c:/source/tomee -Destination c:/tomee -Recurse; \

# SETTING UP ENVIRONMENT PATH VARIABLES FOR JRE & JDK FOLDERS
./source/Environmentvariable.ps1; \

# Installing Tomee service
cmd.exe /c c:/source/tomeeservice.bat; \

# SET TOMEE SERVICE TO RUN UNDER LOCAL SYSTEM ACCOUNT
sc.exe config tomee obj=LocalSystem start=auto; \

# REMOVE TOMEE SETUP FILES FROM SOURCE DIRECTORY
cmd.exe /c rd /S /Q c:\source