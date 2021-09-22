@echo off
if "%1"=="" (
    @echo エラー：引数が指定されていません
)

REM 引数が指定されていな場合、結局空で何も指定されないので、
REM stop と一つだけと、up -d のように二つだけでも大丈夫みたい。
docker-compose -f docker-compose-production.yml %1 %2 %3
REM if not "%2"=="" (
REM     docker-compose -f docker-compose-production.yml %1 %2
REM ) else (
REM     docker-compose -f docker-compose-production.yml %1
REM )
