
#!/bin/bash

exit_status() {
    if [ $? -eq 0 ]
        then
                echo
                echo "-----------------------------------------"
                echo "*   Command Execution Was Successful.   *"
                echo "-----------------------------------------"
                echo
        else
                echo
                echo "-------------------------------------------------------"
                echo "     [Error] Process Command Execution Has Failed!     "
                echo "-------------------------------------------------------"
                echo

        read -p "The last command has exited with an error. Exit script? (y/n)" answer
                if [ "$answer" == "y" ]
                    then
                        exit 1
                fi 
    fi 
}

start() {
            echo
            echo "--------------------------------------------"
            echo "***>>> Upgrading The Operating System <<<***"
            echo "--------------------------------------------"
            echo
}

getUpgrade() {

        sudo apt-get update
        #add -y to the end of the statement above to automatically update without prompt
        exit_status

        #pacman -Qu linux
        #kernal=$?

        #The two commands above work in Arch Linux with pacman.
        #I have no idea if there is a way to accomplish the same goal in any Debian based distro
        #It works by running a "query update" command for "linux" which is the kernal
        #Then the following command (kernal=$?) creates a variable which returns '0' if there is an update. '1' if there isn't
        #In 'exitUpdate()' it references the variable to check if an update to the kernal has been completed
        #If you can find a way to accomplish this same goal, comment out or remove the 'askReboot()' command

        #It is wise to update the system after a kernal update since the update isn't applied until the system has rebooted.
        #It is also wise to be on the latest kernal for security purposes.

}

askReboot() {

        echo
        read -p "Would you like to reboot the system? (y/n)" answer
                if [ "$answer" == "y" ]
                        then
                                kernal=0
                        else
                                kernal=1
                fi

}

upgrade() {

        sudo apt-get upgrade
        #add -y to the end of the statement above to automatically update without prompt
        exit_status

}

cleanUp() {

        sudo apt-get autoclean
        #add -y to the end of the statement above to automatically update without prompt

        sudo apt-get autoremove
        #add -y to the end of the statement above to automatically update without prompt

}

exitUpdate() {

        echo
        echo "-------------------------------------------------------"
        echo ">>>>   Operating System Update Has Been Completed  <<<<"
        echo "-------------------------------------------------------"
        echo

        askReboot
        #Comment out or remove this if you figure out auto kernal update detection

        if [ $kernal -eq 0 ]
                then
                        echo
                        echo "-------------------------------------------------------"
                        echo ">>>>       Kernal Updated. Rebooting Machine.      <<<<"
                        echo "-------------------------------------------------------"
                        echo
                        reboot
                else
                        exit
        fi
}

#calls the functions
start
getUpgrade
upgrade
cleanUp
exitUpdate
