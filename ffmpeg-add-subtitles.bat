@echo off
setlocal EnableDelayedExpansion

set src_mkv_prefix=D:\Userdata\Common\Videos\Anime\[HorribleSubs] Bungou Stray Dogs\[HorribleSubs] Bungou Stray Dogs - 
set src_mkv_suffix= [720p].mkv
set src_ass_prefix=D:\Userdata\Common\Videos\Anime\[HorribleSubs] Bungou Stray Dogs\sub\YakuSub Studio\[HorribleSubs] Bungou Stray Dogs - 
set src_ass_suffix= [720p].ass
set dest_prefix=F:\Video\007_Anime\Bungou Stray Dogs\[Output][HorribleSubs] Bungou Stray Dogs - 
set dest_suffix= [720p].mkv
set output_params=-map 0:0 -map 0:1 -map 0:2 -map 1:0 -c:v copy -c:a copy -c:s copy -metadata:s:s:1 language=ru
set global_params=-loglevel error

for /F "tokens=1,2 delims=:" %%G in (ffmpeg-add-subtitles_episodes.txt) do (
    call :procline "%%G" "%%H"
)

endlocal
exit /B

:procline
setlocal
for /L %%U in %~2 do (
    call :procfile "%~1" "%%U"
)
endlocal
exit /B

:procfile
setlocal
set idx=%~1%~2
echo !idx!
set mkv_name="%src_mkv_prefix%!idx!%src_mkv_suffix%"
set ass_name="%src_ass_prefix%!idx!%src_ass_suffix%"
set dest_name="%dest_prefix%!idx!%dest_suffix%"
ffmpeg %global_params% -i !mkv_name! -i !ass_name! %output_params% !dest_name!
endlocal
exit /B