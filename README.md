# WebM-Clip-Browser
A simple HTML5 WebM clip browser for web servers.

## How to use
You can use your own method of converting to WebM or you can use the batch file provided, which requires ffmpeg.exe, which is available here: http://ffmpeg.zeranoe.com/builds/

Once you have your WebMs:

1. Create a new folder with a HTML-friendly name (no spaces or special characters), which we will call "GTAV"
2. Copy the index.html file from the Test folder into GTAV
3. Open videos.json in your favourite text editor, and make a new entry for GTAV, following standard JSON format. If you are unsure, just edit the Test entry.
4. Add a new entry to the JSON under GTAV for every video with a name for the video (not the file name, just a descriptive name)
5. Now move your WebMs to GTAV, and rename them numerically (1,2,3,4,etc.) according to the order you have them in the JSON.
6. Upload to your webserver!

A live example can be seen here: http://slynch.ovh/WebM-Clip-Browser/
