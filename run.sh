#!/bin/sh
#
#
# JBoss, Home of Professional Open Source. Copyright 2011, Red Hat, Inc., and
# individual contributors as indicated by the @author tags. See the
# copyright.txt file in the distribution for a full listing of individual
# contributors.
# 
# This is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
# 
# This software is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this software; if not, write to the Free Software Foundation,
# Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA, or see the FSF
# site: http://www.fsf.org.


# File: run.sh
#
# Created on Nov 1, 2011 at 10:30:28 AM 
#
# @author <a href="mailto:nbenothm@redhat.com">Nabil Benothman</a>


url=$1;
n=$2;
delay=$3;
nReq=$4;
nClients=$5;

if [ "x$url" = "x" ]; then
	echo "ERROR: The have to provide a URL";
	exit -1;
fi

if [ "x$n" = "x" ]; then
	n=1000;
fi

if [ "x$delay" = "x" ]; then
	delay=1000;
fi

if [ "x$nReq" = "x" ]; then
	nReq=1000000;
fi

if [ "x$nClients" = "x" ]; then
	nClients=$n;
fi

log_file=$(date +%s)-log.txt
filename=$n-$delay-$log_file
printf "Running clients with:\n";
echo "";
printf "\tURL: $url\n";
printf "\tNumber of clients: $n\n";
printf "\tDelay: $delay\n";
printf "\tTotal number of requests: $nReq\n";
printf "\tTotal number of clients: $nClients\n";

printf "\n\t-> Log file: $filename\n";

mvn exec:java -Dexec.mainClass="org.jboss.nio2.client.JioClient" -Dexec.args="$url $n $delay $nReq $nClients" > $log_file

#printf "max \t min \t avg\n" > $filename
#cat $log_file | egrep -v '[a-zA-Z]|^\s*$' >> $filename
#cat $log_file | egrep -v '[a-zA-Z]|^\s*$' >> ~/$n-$delay-$nReq-$nClients-log.txt
cat $log_file | grep ^WRITE >> ~/$n-$delay-$nReq-$nClients-log.txt


#mvn exec:java -Dexec.mainClass="org.jboss.nio2.client.LogParser" -Dexec.args="$filename $nReq"

