#!/usr/bin/env bash

which golint || exit 1

errors=()
for f in $@ ; do
	failedLint=$(golint "$f")
	if [ "$failedLint" ]; then
		errors+=( "$failedLint" )
	fi
done

if [ ${#errors[@]} -eq 0 ]; then
	echo 'Congratulations!  All Go source files have been linted.'
else
	{
		echo "Errors from golint:"
		for err in "${errors[@]}"; do
			echo "$err"
		done
		echo
		echo 'Please fix the above errors. You can test via "golint" and commit the result.'
		echo
	} >&2
	false
fi