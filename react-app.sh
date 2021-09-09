
#!/bin/bash

# to exit when press ctr + c
trap 'echo oh, I am slain; exit' INT
while true; do
 

baseDirectory="/home/mohamed/Desktop/workstation/React"
clientCommand=''
backendCommand=''



read -p 'Enter project name: ' projectname
read -p 'Enter project directory setup: ' projectpath 
read -p 'Does react support Typescript, enter Y/y or N/n: ' tssupport
read -p 'Does pour project need backend setup, Enter Y/y or N/n: ' backend


#creat project folder 
cd $baseDirectory
if [ -d "$projectname" ]
then
	echo -e "\e[33m project name already exist \033[00m"
	read -p 'You want to remove it Y/y else any ' removeFolder
	if  [ "$removeFolder" = "y" ] || [ "$removeFolder" = "Y" ]
	then
		rm -r $projectname
		mkdir $projectname
		cd $projectname
	else
		echo "exist ===>" 
		exit 1
	fi
else
	mkdir $projectname
	cd $projectname	

fi



#project client

if  [ "$tssupport" = "y" ] || [ "$tssupport" = "Y" ]
then
	clientCommand="yarn create react-app client --template typescript"

else
	clientCommand="yarn create react-app client" 
	
fi


#project backend

if  [ "$backend" = "y" ] || [ "$backend" = "Y" ]
then
	read -p 'Backend : Enter "f" for Flask and "e" for Express: ' backendTech


	if [ "$backendTech" = "f" ] || [ "$backendTech" = "F" ]
	then
		echo -e "\e[33m creating flask backend \033[00m"
		python3 -m venv backend
	elif [ "$backendTech" = "e" ] || [ "$backendTech" = "E" ]
	then

		addDependencies="npm i "
		echo "$addDependencies"

		read -p 'Add dependecy (enter q to end): ' dependecy

		# read dependecies
		while [ $dependecy != "q" ]; do
				addDependencies="$addDependencies $dependecy"
				echo "$addDependencies"
				read -p 'Add dependecy (enter q to end): ' dependecy
		done

		echo 'creating client'
		( eval $clientCommand )&

		( echo 'creating Express backend';
		mkdir backend;
		cd backend;
		npm init -y; 
		touch index.js; 
		 eval $addDependencies;
		echo "backend setup finishied!!" )

	else 
		echo -e "\e[1;33m You entered useless choice \033[00m"
	fi
else

	eval $clientCommand	
	
fi

exit 1


done



