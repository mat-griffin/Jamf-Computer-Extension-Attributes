#!/bin/bash

model_number=$(system_profiler SPSoftwareDataType SPHardwareDataType | grep "Model Number")

# Remove "Model Number:" and extra spaces
cleaned_model_number=$(echo $model_number | sed 's/Model Number://;s/ //g')

echo "<result>$cleaned_model_number</result>"
