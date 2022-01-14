#/bin/bash

product_path=/mnt/c/em/products/agent-desktop_15.3-FP9-HFR_6.2.7/modules
version=R6_2_0
revision_threshold=168757
update_sequence_files=$(find $product_path -name "R6_2_0" -exec find {} -name update.sequence \; | xargs grep "Revision")
IFS='
'
for update_sequence_file in $update_sequence_files;do
	sequence_number=$(echo "$update_sequence_file" | awk '{print $3}')
	if [[ ${sequence_number} -gt ${revision_threshold} ]]; then
		echo "$update_sequence_file"
	fi
done
