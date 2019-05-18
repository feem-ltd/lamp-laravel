#!/bin/bash

sudo sed -i -e "s/'timezone' => 'UTC'/'timezone' => 'Asia\/Tokyo'/g" /var/www/html/config/app.php
sudo sed -i -e "s/'locale' => 'en'/'locale' => 'ja'/g" /var/www/html/config/app.php
