#!/bin/bash

sed -i -e "s/'timezone' => 'UTC'/'timezone' => 'Asia\/Tokyo'/g" /var/www/html/config/app.php
sed -i -e "s/'locale' => 'en'/'locale' => 'ja'/g" /var/www/html/config/app.php
