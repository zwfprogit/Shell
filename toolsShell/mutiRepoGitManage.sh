#!/bin/bash

local_root=${PWD}/LinuxC
server="git@github.com"
port="zwfprogit"
project=""

allRepo=(0 1 2 3 4)

repo_name[0]="CClassicUsage"
repo_name[1]="CMakeLists"
repo_name[2]="CProgrammePractice"
repo_name[3]="Python"
repo_name[4]="Shell"

local_path[0]="CClassicUsage"
local_path[1]="CMakeLists"
local_path[2]="CProgrammePractice"
local_path[3]="Python"
local_path[4]="Shell"

if [ ! -d ${local_root} ]; then
	mkdir ${local_root}
	cd ${local_root}
else 
	cd ${local_root}
fi

targetRepo=(${allRepo[*]})

function gitclone()
{
	for x in ${targetRepo[*]}
	do
		git clone ${server}:${port}/${repo_name[${x}]}.git
		cd ${local_root}/${local_path[${x}]}
		git config core.fileMode false
		git config core.autocrlf false
		git config core.safecrlf true
		cd - >> /dev/null
	done
}

function gitdo()
{
	for x in ${targetRepo[*]}
	do
		cd ${local_root}/${local_path[${x}]}
		echo -e "-------->${project}/$repo_name[${x}]<-----------"
		echo git $@
		git $@
		cd - >> /dev/null
	done
}


if [ "$1"=="clone" ]; then
	gitclone
else
	gitdo $@
fi
