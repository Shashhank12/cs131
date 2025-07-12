BEGIN {
	# Setting variables
	FS = ","
	highest_name = ""
	highest_score = -99999
	lowest_name = ""
	lowest_score = 99999
}

# Used to skip the first (header) line
NR==1 {
	next
}


{
	# Uses array to store name, total, average, and status by using current line number (NR)
	name[NR] = $2
	total[NR] = 0
	# Calculates the total by summing the scores for each class
	for (i = 3; i <= NF; ++i) {
		total[NR] += $i	
	}
	# Calls functions
	average[NR] = getAverage(total[NR],NF - 2)
	status[NR] = getStatus(average[NR])
	updateMinMax(name[NR], total[NR])
}

END {
	print "          Student Scores Summary          "
	print "------------------------------------------"
	for (i = 2; i <= NR; ++i) {
		print "Student Name: ", name[i]
		print "Total Score: ", total[i]
		print "Average Score: ", average[i]
		print "Status: ", status[i]
		print ""	
	}

	print "Highest Scoring Student: ", highest_name, "(", highest_score, ")"
	print "Lowest Scoring Student: ", lowest_name, "(", lowest_score, ")"

}

# Returns the average given the total and count 
function getAverage(total, count) {
	return total / count	
}

# Returns pass or fail depending on average score
function getStatus(average) {
	if (average >= 70) {
		return "Pass"
	} else {
		return "Fail"
	}
}

# Updates the student name and score if the new student's score meets the criteria
function updateMinMax(name, score) {
	if (score > highest_score) {
		highest_score = score
		highest_name = name
	}

	if (score < lowest_score) {
		lowest_score = score
		lowest_name = name	
	}
}
