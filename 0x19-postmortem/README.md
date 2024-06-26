![0_-N6a2EtdODipPnGS](https://github.com/Louie-pixel/alx-system_engineering-devops/assets/130101289/0de8095e-1ef5-4806-9ac9-93858ef04530)
Summary
On September 11th, 2018 at midnight the server access went down resulting in a 504 error for anyone trying to access a website. The background on the server is based on a LAMP stack.

Timeline
00:00 PST - 500 error for anyone trying to access the website
00:05 PST - Ensuring Apache and MySQL are up and running.
00:10 PST - The website was not loading properly which on background check revealed that the server was working properly as well as the database.
00:12 PST - After a quick restart to Apache server returned a status of 200 and OK while trying to curl the website.
00:18 PST - Reviewing error logs to check where the error might be coming from.
00:25 PST - Check /var/log to see that the Apache server was being prematurely shut down. The error log for PHP was nowhere to be found.
00:30 PST - Checking php.ini settings revealed all error logging had been turned off. Turning the error logging on.
00:32 PST - Restarting the Apache server and going to the error logs to check what is being logged into the PHP error logs.
00:36 PST - Reviewing error logs for php revealed a mistyped file name which was resulting in incorrect loading and premature closing of Apache.
00:38 PST - Fixing file name and restarting Apache server.
00:40 PST - The server is now running normally and the website is loading properly.


Root Cause and Resolution

The issue was connected with a wrong file name being referred to in the wp-settings.php file. The error was raised when trying to curl the server, wherein the server responded with a 500 error. By checking the error logs it was found that no error log file was being created for the php errors and reading the default error log for Apache did not result in much information regarding the premature closing of the server. Once understood that the errors for php logs were not being directed anywhere the engineer chose to review the error log setting for the PHP in the php.ini file and found that all error logging was turned off. Once turned on, the error logging the Apache server was restarted to check if any errors were being registered in the log. As suspected, the PHP log showed that a file with a .phpp extension was not found in the wp-settings.php file. This was a misspelled error that resulted in the error to site access. As this was one server that the error was found in, this error might have been replicated in other servers as well. An easy fix by changing the file extension byPuppett would result in the fix being made to other servers as well. Quick deployment of the puppet code replaced all misspelled file extensions with the right ones and restarting the server resulted in proper loading of the site and server.

Corrective and Preventive Measures
All servers and sites should have error logging turned on to easily identify errors if anything goes wrong.
All servers and sites should be tested locally before deploying on a multi-server setup this will result in correcting errors before going live resulting in less fixing time if the site goes down
