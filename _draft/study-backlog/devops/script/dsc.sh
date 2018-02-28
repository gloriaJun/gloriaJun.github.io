#!/bin/bash
### docker container control box  V. 2.2
### Made by ralf goody80762@gmail.com
#

## Make sure build DIR
BUildDirConf="$HOME/build_dir.conf"
	if [ ! -f $BUildDirConf ];then
		touch  $BUildDirConf
	fi
extra_input=$1
BuildDir=`cat $BUildDirConf`
exefile=`which dcs`


## Please modify under variable for the private repository if you have.
#Docker_repo=`cat /data/z/etc/init.d/docker | grep "^connection" | awk -F '=' '{print $2}' | sed -e 's/"//g' `
#Docker_repo="[Docker repository IP]:[port]"
Docker_repo=""

## find a command
Docker_comm=`which docker | head -1`
## OS Check
Docker_version=`docker -v | awk -F',' '{print $1}'`
## Check the sudo
	if [[ `(which sudo 2> /dev/null)` = "" ]];then
		SUDO=""
	else
		SUDO="sudo"
	fi

Comm="$SUDO $Docker_comm"

ChkOS=`cat /etc/*-release 2> /dev/null | head -1`
        if [[ $(uname) == Linux ]];then
			osv="linux"
		elif [[ $(uname) == Darwin ]];then
			Comm="$Docker_comm"
			osv="osx"
        fi


## Temporary file create for work memory
Tmp_imgfile="$HOME/docker_imgtmp.txt"
Tmp_psfile="$HOME/docker_pstmp.txt"
Tmp_psAfile="$HOME/docker_psAtmp.txt"
Tmp_tag="$HOME/docker_tag.txt"

exit_abnormal() {
stty echo
rm -f $Tmp_imgfile $Tmp_psfile $Tmp_psAfile $Tmp_tag 2> /dev/null
exit 1
}


### Break sign catch for line break fix
trap exit_abnormal SIGINT SIGTERM SIGKILL




BAR="=========================================================================================================================================================" > $Tmp_imgfile
echo $BAR  >> $Tmp_imgfile
echo "   [:: Docker Images ::]"   >> $Tmp_imgfile
echo $BAR  >> $Tmp_imgfile
$Comm images |awk '{printf "%.2d | "$0"\n",NR-1}' | sed -e 's/^00/  /g' >> $Tmp_imgfile


echo ""  >> $Tmp_psAfile
echo ""  > $Tmp_psAfile
echo $BAR  >> $Tmp_psAfile
echo "   [:: Active Processors ::]"  >> $Tmp_psAfile
echo $BAR  >> $Tmp_psAfile
$Comm ps |awk '{printf "%.2d | "$0"\n",NR-1}' |sed -e 's/^00/  /g' >> $Tmp_psAfile

echo ""  >> $Tmp_psfile
echo ""  > $Tmp_psfile
echo $BAR  >> $Tmp_psfile
echo "   [:: All Processors ::]"  >> $Tmp_psfile
echo $BAR  >> $Tmp_psfile
$Comm ps -a |awk '{printf "%.2d | "$0"\n",NR-1}' |sed -e 's/^00/  /g' >> $Tmp_psfile
	if [[ $osv = "osx" ]];then
		sed -i "" 's/^0 /  /g' $Tmp_imgfile
		sed -i "" 's/^0 /  /g' $Tmp_psAfile
		sed -i "" 's/^0 /  /g' $Tmp_psfile
	else
		sed -i  's/^0 /  /g' $Tmp_imgfile
		sed -i  's/^0 /  /g' $Tmp_psAfile
		sed -i  's/^0 /  /g' $Tmp_psfile
	fi


Print_screen(){
## Print screen
clear
cat $Tmp_imgfile $Tmp_psAfile $Tmp_psfile

echo ""
echo ""
#echo "======================================"
echo " Please Insert a command as below  :) "
echo "= Processor ==========================  = Image ==============================  = Commit & Push ====================="
echo " Run the container ---------- [ run  ]| Pull Image     ------------- [ pull ] | Commit --------------------- [ ci   ]"
echo " Start & Attach    ---------- [ sa   ]| Remove Image   ------------- [ rmi  ] | Tagging & Push ------------- [ push ]"
echo " Stop              ---------- [ stop ]| Build Image    ------------- [ build] | Prune image/volume/network - [ prune]"
echo " Send command      ---------- [ exec ]| Purge volume   ------------- [ clean] |"
echo " Into the running docker ---- [ it   ]| Save All images to tarball - [ save ] |"
echo " Remove PS         ---------- [ rm   ]| Load the image from DIR ---- [ load ] |"
echo " Show log          ---------- [ log  ]| --------------------------------------| upgrade check & upgrade       upgrade"
echo " Purge Processor   ---------- [ purge]| Cli ---------- [ Type free as below ] | Exit                           Ctrl+c"
echo " All Processor stop!! ------- [ aps  ]| ex) stop 910930 19809 102039 09103    | $Docker_version"
echo "======================================| ===================================== | ====================================="

}


	if [[ $extra_input = "" ]];then
		Print_screen
		read CommandX
	else
		CommandX=$extra_input
	fi


## Make a number & array
ImageNum=`tail -1 $Tmp_imgfile | awk '{print $1}'`
PsNum=`tail -1 $Tmp_psfile | awk '{print $1}'`
PsANum=`tail -1 $Tmp_psAfile | awk '{print $1}'`
ImageIDArray=(`cat $Tmp_imgfile | awk '{print $5}' | tail -n +4`)
ProcessorIDArray=(`cat $Tmp_psfile | awk '{print $3}' | tail -n +5`)
ProcessorAIDArray=(`cat $Tmp_psAfile | awk '{print $3}' | tail -n +5`)


## Function for command as below
run_container(){
	echo " == Do you need to make port forwarding ? [host-port:container-port or null] "
	read portcheck
		if [[ $portcheck = "" ]];then
			port_expose=""
		else
			port_parser=`echo "$portcheck"  | sed -e 's/ [0-9]*:[0-9]/ -p&/g'`
			port_expose="-p $port_parser"
		fi
	$Comm run $port_expose -it --name $2 ${ImageIDArray[$1]}  /bin/sh
}


sa_container(){
	$Comm start $1
	$Comm attach $1
}


comm_container(){
	$Comm exec ${ProcessorAIDArray[$1]} $2
	echo " - Please insert a any key if you have done - "
	read
}

build_image(){

	if [[ ! -d $BuildDir ]];then
		echo "$BAR"
		echo " Please insert a Directory for image build under the Dockerfile [ex) /data/git/dockerfiles_dir]"
		read ReadDir
		#sudo sed -i "s#^BuildDir=\"\"#BuildDir=\"$ReadDir\"#g" $exefile
		echo "$ReadDir" > $BUildDirConf
		cd $ReadDir
	else
		cd $BuildDir
	fi

	if [[ ! -f ./docker_build_auto.sh ]];then
		echo "$BAR"
		echo "Do you need to install docker_build_auto.sh here ? [ y/n ]"
		read Answ
			if [[ $Answ = "y" ]] || [[ $Answ = "Y" ]];then
				wget goody80.github.io/docker_build_auto/docker_build_auto.sh
				sudo chmod 755 docker_build_auto.sh
			else
				echo "$BAR"
				echo "You need to install the docker_build_auto.sh script for this work"
				echo "$BAR"
				exit 0
			fi
	fi
	./docker_build_auto.sh
}

rm_container(){
	$Comm rm ${ProcessorIDArray[$1]}
}

it_container(){
        $Comm exec -it ${ProcessorAIDArray[$1]} /bin/sh
}

pull_image(){
	$Comm pull $1
}


remove_image(){
	$Comm rmi -f ${ImageIDArray[$1]}
}

ci_image(){
	$Comm commit ${ProcessorAIDArray[$1]} $2
	echo "$Comm commit ${ProcessorAIDArray[$1]} $2"
}


save_all_images(){

echo "Please make sure the directory for backup [default= ~/]:"
read Save_Dir
	if [[ $Save_Dir = "" ]];then
		Save_Dir="$HOME"
	else
		echo " Docker image will be save in \"$Save_Dir\" "
	fi

	docker_images=$($Comm images | egrep -v "^REPOSITORY" | awk '{print $1":"$2}')
	docker_image_count=$($Comm images | egrep -v "^REPOSITORY" | wc -l)
	mkdir -p $Save_Dir/tmp`date +%Y%m%d`/

		echo " === Exporting the image to files === "
		count=1
		for i in $docker_images
		do
			echo "[ $count / $docker_image_count ] - $i"
			tar_name=$(echo "$i" |sed -e 's/:/_/g' -e 's#/#_#g' )
			$Comm save $i > $Save_Dir/tmp`date +%Y%m%d`/$tar_name.tgz
			let count=$count+1
		done
        echo " === Compressing image files to Tarball file  (in $Save_Dir/docker_images_output_`hostname`_`date +%Y%m%d`.tgz) === "
        cd $Save_Dir/tmp`date +%Y%m%d`
        tar zcvf  $Save_Dir/docker_images_output_`hostname`_`date +%Y%m%d`.tgz *.tgz 2> /dev/null
	cd $Save_Dir
	rm -Rf $Save_Dir/tmp`date +%Y%m%d` 2> /dev/null
	echo " === Done  === "
	echo " === You can use this file $Save_Dir/docker_images_output_`hostname`_`date +%Y%m%d`.tgz for Backup or magration === "
	sleep 1
}

load_all_images(){
	echo " Please insert a Directory name as the file existed "
	read tarball_images_dir
		if [[ $tarball_images_dir = "" ]];then
			echo " Please make sure the Directory name !!"
			exit
		fi
	cd $tarball_images_dir
	## Exception for the save file from dcs
	tar zxfv docker_images_output*.tgz  2> /dev/null
	docker_images_tgz=$(ls $tarball_images_dir |grep ".tgz" |egrep -v "docker_images_output*.tgz")
	docker_images_count=$(ls $tarball_images_dir |grep ".tgz" |egrep -v "docker_images_output*.tgz" |wc -l)
	echo " === Decompressing the file and apply the image to the Docker... === "
	count=1
		for i in $docker_images_tgz
		do
			echo "[ $count / $docker_images_count ] - $i"
			$Comm load < $tarball_images_dir/$i
			let count=$count+1
		done

	echo " === Done  === "
	sleep 1
}

Log_container(){
	clear
	$Comm logs ${ProcessorAIDArray[$1]}
#	echo "$Comm log ${ProcessorAIDArray[$1]}"
	echo ""
	echo " - Please insert an any key if you all done -"
	read
}

Stop_container(){
	$Comm stop ${ProcessorAIDArray[$1]}
	echo "$Comm stop ${ProcessorAIDArray[$1]}"
}

Purge_image(){
	$Comm rm -v $($Comm ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	$Comm rm -v $($Comm ps --filter status=created -q 2>/dev/null) 2>/dev/null
}

All_stop_process(){
	$Comm ps  |awk '{print $1}' | egrep -v 'CONTAINER' | xargs  $Comm stop
	echo "---------------------  $Comm  ps  |awk '{print $1}' | egrep -v 'CONTAINER' | xargs  $Comm  stop----------------------"
}

Purge_Old_image(){
	#$Comm  rmi $(docker images --filter "dangling=true" -q --no-trunc) 2> /dev/null
	$Comm container prune --force 2>/dev/null
	echo " --- container clean: Done ---"
	echo ""
	$Comm image prune --force 2>/dev/null
	echo " --- Image clean: Done ---"
	echo ""
	$Comm network prune --force 2>/dev/null
	echo " --- Network clean: Done ---"
	echo ""
	$Comm volume prune --force 2>/dev/null
	echo " --- Volume clean: Done ---"
	sleep 3
}

Clean_volume(){
	$Comm volume ls -qf dangling=true | xargs $Comm volume rm
}



	if [[ $(echo "$CommandX" | grep '\-y') != "" ]];then
		answ="y"
		CommandX=`echo "$CommandX" | sed -e 's/ -y//g'`
	fi


	## Case selection for instructions
	if [[ $(echo "$CommandX" | awk '{print $2}' ) = "" ]];then
		case "$CommandX" in
			build)
				build_image
				;;
           		run)
				echo " == Please insert a image number [01 - $ImageNum ]"
				read ImageNum
				echo " == Please insert a new name for Run :"
				read DockerName
					if [[ $DockerName != "" ]];then
				                run_container  $ImageNum $DockerName
					else
						echo " == No Image ID == "
					fi

				;;
			sa)
				echo " == Please insert docker name for start :"
				read St_docker
					if [[ $St_docker != "" ]];then
				                sa_container $St_docker
					else
						echo " == No Processor ID == "
					fi
				;;
			exec)
				echo " == Please insert a Active Processor number [01 - $PsANum ]"
				read ActiveProcessorNum
				echo " == Please insert a command for send to container ?"
				read CommandToContainer
					if [[ $ActiveProcessorNum != "" ]];then
				                comm_container $ActiveProcessorNum $CommandToContainer
					else
						echo " == No Processor No. == "
					fi
				;;
			it)
				echo " == Please insert a Processor number for into that [01 - $PsANum ]"
				read ProcessorNum
					if [[ $ProcessorNum != "" ]];then
						it_container $ProcessorNum
					else
						echo " == No Processor No. == "
					fi
				;;
			rm)
				echo " == Please insert a Processor number for Remove [01 - $PsNum ]"
				read ProcessorNum
				echo " == [ ${ProcessorIDArray[$ProcessorNum]} ]: Are you sure ? [y / n] "
				read RmAnswer
					if [[ $ProcessorNum != "" ]];then
						if [[ $RmAnswer = "y" ]];then
					                rm_container $ProcessorNum
						fi
					else
						echo " == No Processor No. == "
					fi
				;;
			pull)
				echo " == Please insert an image name for pulls:"
				read ImagePullname
					if [[ $ImagePullname != "" ]];then
				                pull_image $ImagePullname
					else
						echo " == No image name == "
					fi
				;;
			aps)
				if [[ $answ != "y" ]];then
					echo " == All active processor will be stop. Are sure that ? [ y/n ]:"
					read AllprocessQ
						if [[ $AllprocessQ = "y" ]];then
					                All_stop_process
						fi
				else
					All_stop_process
				fi
				;;
			purge)
				if [[ $answ != "y" ]];then
					echo " == No use processor will be remove. Are sure that ? [ y/n ]:"
					read ImagePurge
						if [[ $ImagePurge = "y" ]];then
					                Purge_image
						fi
				else
					Purge_image
				fi
				;;
			prune)
				if [[ $answ != "y" ]];then
					echo " == No use image will be remove. Are sure that ? [ y/n ]:"
					read ImageOldPurge
						if [[ $ImageOldPurge = "y" ]];then
					                Purge_Old_image
						fi
				else
					Purge_Old_image
				fi
				;;
			clean)
				if [[ $answ != "y" ]];then
					echo " == No use volume will be remove. Are sure that ? [ y/n ]:"
					read VolumeClean
						if [[ $VolumeClean = "y" ]];then
				        	        Clean_volume
						fi
				else
						Clean_volume
				fi
				;;

			save)
				if [[ $answ != "y" ]];then
					echo " == All images will be backup to file. OK ? [ y/n ]:"
					read SaveImg
						if [[ $SaveImg = "y" ]];then
				        	        save_all_images
						fi
				else
						save_all_images
				fi
				;;
			load)
				load_all_images
				;;

			rmi)
				echo " == Please insert a number for remove the image [01 - $ImageNum] "
				read RmImageNum
				echo " == [ ${ImageIDArray[$RmImageNum]} ]: Are you sure ? [y / n]"
				read RmIAnswer

					if [[ $RmImageNum != "" ]];then
						if [[ $RmIAnswer = "y" ]];then
							remove_image $RmImageNum
						fi
					else
						echo " == No image No. == "
					fi
				;;

			ci)
				echo " == Please insert a number of Active processor [01 - $PsANum] "
				read CiNum
				echo " == Please make sure the name for use:"
				read CiAnswer
					if [[ $CiNum != "" ]];then
							ci_image $CiNum $CiAnswer
					else
						echo " == No image No. == "
					fi

				;;
			push)
					if [[ $Docker_repo != "" ]];then
						$Comm images | fgrep -v "$Docker_repo" | awk '{print NR-1,$0}' | sed -e 's/^0/ /g' > $Tmp_tag
					else
						$Comm images | awk '{print NR-1,$0}' | sed -e 's/^0/ /g' > $Tmp_tag
					fi

				cat $Tmp_tag
				TagNum=`cat $Tmp_tag | tail -1 | awk '{print $1}'`

				echo " == Please choose a number for tag and push [01 - $TagNum] "
				read TagPush
				echo  -e "\033[32;3;7m * Please login first to the Docker registry \033[0m ex) docker login"
					if [[ $TagPush != "" ]];then
						 echo "Taget image= `grep \"^$TagPush \" $Tmp_tag | awk '{print $2":"$3}'`"
						 TagetPush=`grep "^$TagPush " $Tmp_tag | awk '{print $2":"$3}'`
						if [[ $Docker_repo = "" ]];then
							echo "== Do you need to make a tag ? [y / n]"
							read Tagcomm
								if [[ $Tagcomm = "y" ]];then
									echo "Please insert a tag name:"
									read Tagname
									$Comm tag $TagetPush $Tagname
									$Comm push $Tagname
								else
									$Comm push $TagetPush
								fi
						else
							$Comm tag $TagetPush $Docker_repo/$TagetPush
							$Comm push $Docker_repo/$TagetPush
						fi
					fi
				;;

			log)
				echo " == Please insert a number of Active processor [01 - $PsANum] "
				read LogNum
					if [[ $LogNum != "" ]];then
							Log_container $LogNum
					else
						echo " == No image No. == "
					fi
				;;
			stop)
				echo " == Please insert a number of Active processor [01 - $PsANum] "
				read StopNum
					if [[ $StopNum != "" ]];then
							Stop_container $StopNum
					else
						echo " == No image No. == "
					fi
				;;

			upgrade)
				Current_ver=`cat $exefile  |grep 'V. [0-9].[0-9]' | sed -e 's/^### [[:alnum:]* ]* V. //g'`
				Latest_ver=`curl -sLH "Cache-Control: no-cache" bit.ly/dcs_ |grep 'V. [0-9].[0-9]' | sed -e 's/^### [[:alnum:]* ]* V. //g'`
				if [[ $Current_ver < $Latest_ver ]];then
					curl -sLH "Cache-Control: no-cache" bit.ly/dcs_ -o /tmp/curl
					sudo cp  /tmp/curl $exefile
					sudo rm -f /tmp/curl
					chmod 755 $exefile
					echo " === dcs has been updated!! - Version $Current_ver -> $Latest_ver ==="
					exit 0
				else
					echo " === Now you have latest version of dcs - Version $Current_ver ==="
					sleep 3
				fi
				;;

		esac
	else
		$Comm $CommandX
	fi

        if [[ $extra_input = "" ]];then
		$exefile
        fi
