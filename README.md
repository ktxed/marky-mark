# marky-mark

utility powershell script for watermarking images

## How to launch

- extract zip (provided in the release)
- execute the bat file | execute the powershell script

## Workflow

The workflow is pretty simple at this point. You select a folder containing the photos you want to watermark. After that you must select a destion folder where the tool will save the watermarked files.

- select input folder (not recursing through subfolders, yet!)
- select output folder
- wait for processing to complete


## Dependencies

* GraphicsMagick should be present in the gm folder

## NOTES / Limitations

- only supports watermarking jpg/jpeg files
- tested on windows 10 x64
- you may need to configure your OS to enable the execution of powershell scripts (more info <a href="https://superuser.com/a/106363/196525">here</a> on how to do this)

## Future / Plans

- Recurse source folder. Mirror the input folder structure in the output folder.
- Provide a proper UI
- Remember last used paths
- Logging
- Switch from PowerShell to something else?
