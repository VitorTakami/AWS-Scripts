#!/bin/bash
read -p "Type instance name: " INSTANCE_NAME
INSTANCE_NAMEs=($(aws ec2 describe-tags --output text | grep -i "$INSTANCE_NAME" | grep instance | awk '{ print $5 }'))
INSTANCE_ID=`aws ec2 describe-tags --output text | grep -i "$INSTANCE_NAME" | grep instance | awk '{ print $3 }'`
INSTANCE_IDs=`aws ec2 describe-tags --output text | grep -i "$INSTANCE_NAME" | grep instance | awk '{ print $3 }' | wc -l`
INSTANCE_STATE=`aws ec2 describe-instance-status --instance-ids $INSTANCE_ID | grep running`
y=0

if [ "$INSTANCE_STATE" > 1 ];
then
	echo "We find more than one instance name base on your description. Check the instances that we find below : "
	for x in ${!INSTANCE_NAMEs[@]};
	do 
		echo "$x - ${INSTANCE_NAMEs[$x]}";
	done
fi

#if [ -z "$INSTANCE_STATE" ];
#then
#	echo "Starting instance"
#	aws ec2 start-instances --instance-ids "$INSTANCE_ID"
#else
#	echo "Instance already running"
#fi
