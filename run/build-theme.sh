#!/bin/bash -x

# Author : INSAF | 2hats
# Create Vendor and Starting Theme.
# `bash run/theme-theme.sh`

DIRECTORY="app/design/frontend/"
THIS_DIRECTORY="run/"
THEME_DIRECTORY=${THIS_DIRECTORY}"/Theme"

# Create vendor folder if desn't exist
read -p "What is your Vendor name? (default: Vendor)" VENDOR_USER
if [[ -z "$VENDOR_USER" ]]; then
    VENDOR='Vendor'
else
     VENDOR=$VENDOR_USER
fi
mkdir -p "${DIRECTORY}${VENDOR}"

#Theme Moved to vendor
cp -rf ${THEME_DIRECTORY} "${DIRECTORY}${VENDOR}/"

read -p "What is your Theme name? (default: Theme)" THEME_NAME_USER
if [[ -z "$THEME_NAME_USER" ]]; then
    THEME_NAME='Theme'
else
    THEME_NAME=$THEME_NAME_USER
  mv "${DIRECTORY}${VENDOR}/Theme" "${DIRECTORY}${VENDOR}/$THEME_NAME"
fi
NEW_THEME_DIRECTORY=${DIRECTORY}${VENDOR}/$THEME_NAME

# Update Theme title theme.xml
read -p "What is your Theme title? (default: Custom theme)" THEME_TITLE_USER
if [[ -z "$THEME_TITLE_USER" ]]; then
    THEME_TITLE='Custom theme'
else
    THEME_TITLE=$THEME_TITLE_USER
    sed -i -e "s/Custom theme/$THEME_TITLE/g" "${NEW_THEME_DIRECTORY}/theme.xml"
fi

# Update parent theme //theme.xml
read -p "What is your parent theme? (default: blank)" PARENT_THEME_USER
if [[ -z "$PARENT_THEME_USER" ]]; then
    PARENT_THEME='blank'
else
    PARENT_THEME=$PARENT_THEME_USER
    sed -i -e "s/blank/$PARENT_THEME/g" "${NEW_THEME_DIRECTORY}/theme.xml"
fi

# Update component name //registration.php
sed -i -e "s/Vendor\\/Theme/${VENDOR}\\/${THEME_NAME}/g" "${NEW_THEME_DIRECTORY}/registration.php"
echo "registration.php  updated"

# Update package name // composer.json
sed -i -e "s/Vendor\\/Theme/${VENDOR}\\/${THEME_NAME}/g" "${NEW_THEME_DIRECTORY}/composer.json"

echo "successfull"