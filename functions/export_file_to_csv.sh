exit 1 # Sike this doesn't really work
psql -f ./projects.sql -A -F , -o ~/Desktop/out.csv
