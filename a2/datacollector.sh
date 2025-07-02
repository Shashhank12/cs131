#!/bin/bash

echo "Enter URL for dataset: "
read url

echo "Downloading data"
filename=$(basename "$url")
wget "$url"
echo "Download complete"

if [[ "$filename" == *.zip ]]; then
        unzip -o "$filename"
        rm "$filename"
fi

for csv in ./*.csv; do
        summaryname="$(basename "$csv" .csv)_summary.md"
        echo "# Feature Summary for $(basename "$csv")" > "$summaryname"
        echo "" >> $summaryname
        echo "## Feature Index and Names" >> $summaryname
        
        delimiter=$(head -n 1 "$csv" | sed 's/[^,;|\t]//g' | head -c 1)
        if [[ -z "$delimiter" ]]; then
                echo "No delimiter found in $csv, assuming semicolon (;) as default."
                delimiter=";"
        fi
        head -n 1 "$csv" | sed 's/"//g' | awk -F"$delimiter" '{ for(i=1; i<=NF; i++) { print i ". " $i } }' >> "$summaryname"

        echo "" >> $summaryname
        echo "## Statistics (Numerical Features)" >> $summaryname
        echo "| Index | Feature            | Min    | Max     | Mean   | StdDev |" >> "$summaryname"          
        echo "|-------|--------------------|--------|---------|--------|--------|" >> "$summaryname"
        
        header=$(head -n 1 "$csv" | sed 's/"//g')
        num=$(echo "$header" | awk -F"$delimiter" '{print NF}')

        for ((i=1; i<=num; i++)); do
		featurename=$(echo "$header" | cut -d"$delimiter" -f"$i")

            	stats=$(awk -F "$delimiter" -v col="$i" '
                NR > 1 && $col != "" {
                	if (count==0) {min=$col; max=$col}
                    	if ($col < min) min=$col;
                    	if ($col > max) max=$col;
                    	sum += $col;
                    	sumsq += $col*$col;
                    	count++;
                }
                END {
                	if (count > 0) {
                        	mean = sum/count;
                        	stddev = sqrt(sumsq/count - mean*mean);
                        	printf "%.2f\t%.2f\t%.3f\t%.3f", min, max, mean, stddev;
                }
                }' "$csv")

		read -r min max mean stddev <<< "$stats"
            
            	if [[ -z "$min" ]]; then
                	min="N/A"
                	max="N/A"
                	mean="N/A"
                	stddev="N/A"
            	fi
            
		echo "| $i     | $featurename | $min | $max | $mean | $stddev |" >> "$summaryname"
        done
	echo "Feature summary completed for $(basename "$csv") with the name $summaryname"

done
echo "Script completed"
