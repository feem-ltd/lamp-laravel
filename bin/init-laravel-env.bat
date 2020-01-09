@ECHO OFF

SET SED=docker-compose exec laravel sed -i -e "s/DB_HOST=.*/DB_HOST=mysql/g" /var/www/html/.env
ECHO %SED%
%SED%

IF not "%ERRORLEVEL%"  == "0" (
    ECHO エラーが発生したので処理を終了します。
    GOTO BAT_END
)

SET SED=docker-compose exec laravel sed -i -e "s/DB_DATABASE=.*/DB_DATABASE=laravel/g" /var/www/html/.env
ECHO %SED%
%SED%

IF not "%ERRORLEVEL%"  == "0" (
    ECHO エラーが発生したので処理を終了します。
    GOTO BAT_END
)

SET SED=docker-compose exec laravel sed -i -e "s/DB_USERNAME=.*/DB_USERNAME=user/g" /var/www/html/.env
ECHO %SED%
%SED%

IF not "%ERRORLEVEL%"  == "0" (
    ECHO エラーが発生したので処理を終了します。
    GOTO BAT_END
)

SET SED=docker-compose exec laravel sed -i -e "s/DB_PASSWORD=.*/DB_PASSWORD=user_password/g" /var/www/html/.env
ECHO %SED%
%SED%

IF not "%ERRORLEVEL%"  == "0" (
    ECHO エラーが発生したので処理を終了します。
    GOTO BAT_END
)

:BAT_END
