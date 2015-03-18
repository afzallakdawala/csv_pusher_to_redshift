# csv_pusher_to_redshift
Read csv file and append data to redshift

1. Set your environment variable to access your redshift database
  `export REDSHIFT_CONNECTION=redshift://YOUR-USERNAME:YOUR-PASSWORD@YOUR-HOST:YOUR-PORT/YOUR-DB-NAME` 
2. Add your files to csv folder which you want to read and insert data in redshift. Note your file name should match exact name with your table_name on redshift and even columns also.
3. After adding type this command `ruby init.rb`
4. Now it will prompt you to add filename which you want data to read and insert into that.
5. Next it will prompt you again for empty complete table and insert from fresh, If you have pressed y so it will delete all record from that table and insert with newly csv data.
