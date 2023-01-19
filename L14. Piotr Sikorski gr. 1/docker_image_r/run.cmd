@echo off
docker build -t psikorski/docker_image_r .
set output_loc=%cd%\output
echo path: %output_loc%
docker run -it --rm -v "%output_loc%":/output psikorski/docker_image_r