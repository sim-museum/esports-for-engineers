# copy .vhs replay files and briefing/debriefing file created in the last two hours to afterGameReport
find ./WP/drive_c/FreeFalcon6/acmibin -name "*.vhs" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
find ./WP/drive_c/FreeFalcon6 -name "*.txt" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
find ./WP/drive_c/FreeFalcon6 -name "*.frc" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
find ./WP/drive_c/FreeFalcon6 -name "*.cam" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
find ./WP/drive_c/FreeFalcon6 -name "*.his" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
