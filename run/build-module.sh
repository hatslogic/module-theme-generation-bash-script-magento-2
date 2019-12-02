#!/bin/bash -x

# Author : INSAF | 2hats
# Create Vendor and Starting Theme.
# `bash run/build-module.sh`

DIRECTORY="app/code/"
THIS_DIRECTORY="run/"
MODULE_DIRECTORY=${THIS_DIRECTORY}"/Module"

# Create vendor folder if desn't exist
read -p "What is your Vendor name? (default: Vendor)" VENDOR_USER
if [[ -z "$VENDOR_USER" ]]; then
    VENDOR='Vendor'
else
     VENDOR=$VENDOR_USER
fi
mkdir -p "${DIRECTORY}${VENDOR}"

#Module Moved to vendor
cp -rf ${MODULE_DIRECTORY} "${DIRECTORY}${VENDOR}/"

read -p "What is your Module name? (default: Module)" MODULE_NAME_USER
if [[ -z "$MODULE_NAME_USER" ]]; then
    MODULE_NAME='Module'
else
    MODULE_NAME=$MODULE_NAME_USER
  mv "${DIRECTORY}${VENDOR}/Module" "${DIRECTORY}${VENDOR}/${MODULE_NAME}"
fi
NEW_MODULE_DIRECTORY=${DIRECTORY}${VENDOR}/${MODULE_NAME}

# Update module name //theme.xml
 sed -i -e "s/Vendor_Module/${VENDOR}_${MODULE_NAME}/g" "${NEW_MODULE_DIRECTORY}/etc/module.xml"

# Update module component name //registration.php
 sed -i -e "s/Vendor_Module/${VENDOR}_${MODULE_NAME}/g" "${NEW_MODULE_DIRECTORY}/registration.php"
echo "module build successfully"

echo "enabing module..."
php bin/magento module:enable ${VENDOR}_${MODULE_NAME}

echo "upgrading database by running setup:upgrade, please wait..."
php bin/magento setup:upgrade

php bin/magento module:status ${VENDOR}_${MODULE_NAME}