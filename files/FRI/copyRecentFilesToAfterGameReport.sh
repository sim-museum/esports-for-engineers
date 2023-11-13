# copy game files created in the last 2 hours to afterGameReport
find . -name "*.sgf" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
find . -name "*.rsgf" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
find . -name "*.rsgf.csv" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;

