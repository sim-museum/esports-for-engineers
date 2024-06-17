# copy replay .cam files created in the last 2 hours to afterGameReport
find ./MigAlley/WP/drive_c/rowan/mig/Videos -name "*.cam" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
find "./BattleOfBritain/WP/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain/VIDEOS" -name "*.cam" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
# Mig Alley campaign
find . -name "*.sav" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
# Battle of Britain Luftwafee campaign
find . -name "*.bsL" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
# Battle of Britain RAF campaign
find . -name "*.bsR" -type f -mmin -120 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
