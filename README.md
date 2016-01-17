# Poc_BigData_Script

This project allows service company to find the good profile for a given mission and also look for good mission for a given profile.

The system takes as input a set of résumé and a set of mission and using a particular algorithm call TF-IDF to match the resumé with the mission. 

The process is the following :
- First an extraction of the text of all resumé and all mission is done
- Secondly, we identify certain words and give them a weight. (such weights should be used in the TF-IDF algorthm to match the same word in the resumé and in the mission)
