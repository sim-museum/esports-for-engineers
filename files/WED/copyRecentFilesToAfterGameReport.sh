# copy .pgn files created in the last 2 hours to afterGameReport
find . -name "*.pgn" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
