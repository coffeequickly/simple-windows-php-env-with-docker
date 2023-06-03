@echo off

REM 현재 스크립트 파일의 절대 경로 가져오기
for %%I in ("%~dp0.") do set "project_path=%%~fI"

REM Docker 시스템 정리
docker system prune -f

REM "php_development_env" 컨테이너 종료
docker stop php_development_env > nul 2>&1
docker rm php_development_env > nul 2>&1

REM Docker 컨테이너 이름 설정
set "container_name=php_development_env"

REM Docker 컨테이너 빌드
docker build -t "%container_name%" "%project_path%"

REM Docker 컨테이너 실행
docker run -d -p 8080:80 --name "%container_name%" -v "%project_path%:/var/www/html" "%container_name%"

start http://localhost:8080

docker logs -f "%container_name%"

REM 스크립트 종료
pause
