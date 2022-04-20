AUTOMOUNT=true
SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true
REPLACE="
"

print_modname() {
ui_print "
 ****************************
 - Module: $MODNAME
 - ID: $MODID
 - Author: LoveCany
 ****************************
 "
}


on_install() {
    mkdir -p $MODPATH/system/product/etc/device_features/
    cp -rf /product/etc/device_features/* $MODPATH/system/product/etc/device_features/
    dir=$MODPATH/system/product/etc/device_features/*
filelist=`ls $dir`
for FIND_FILE in $filelist
do
	sed -i 's/support_dc_backlight\">false/support_dc_backlight\">true/g' $FIND_FILE
sed -i 's/support_secret_dc_backlight\">true/support_secret_dc_backlight\">false/g' $FIND_FILE
FIND_STR="<item>90<"

if [ `grep -c "$FIND_STR" $FIND_FILE` -eq '0' ];then
    sed -i 's/<item>60/<item>90<\/item>\n<item>60/g' $FIND_FILE
fi
done
}

set_permissions() {
set_perm_recursive  $MODPATH  0  0  0755  0644
}