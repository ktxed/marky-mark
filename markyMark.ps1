clear
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

Function Get-Folder($message)
{
    $folder = ""	

    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.rootfolder = "MyComputer"
	$dialog.Description = $message

    if($dialog.ShowDialog() -eq "OK") {
        $folder = $dialog.SelectedPath
    }
	
	$folder
}

Function Get-File($message)
{
    $folder = ""	

    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title = $message

    if($dialog.ShowDialog() -eq "OK") {
        $folder = $dialog.FileName
    }
	
	$folder
}

Function AskConfirmation ($message) 
{
	$result = [System.Windows.Forms.MessageBox]::Show($message, 'Is this OK?', 'YesNo', 'Error')
	$result = $result -eq 'Yes'
	return $result
}

$inputFolder = Get-Folder "Please select input folder"
$msgInputFolder = ("Selected input folder: '$inputFolder'")


$outFolder = Get-Folder "Please select output folder"
$msgOutputFolder = ("Selected output folder: '$outFolder'")

#$watermarkFilePath = Get-File ("Select watermark file (transparent png)")
#$msgWatermarkFilePath = ("Selected watermark file path: '$watermarkFilePath'")

#if ((AskConfirmation ($msgInputFolder + "`n" + $msgOutputFolder  + "`n" + $msgWatermarkFilePath)) -eq $false) {
if ((AskConfirmation ($msgInputFolder + "`n" + $msgOutputFolder)) -eq $false) {
	echo 'Quitting...'
	exit
}

# $inputFolder = ".."
# $outFolder = ".."

$watermarkFilePath = (Resolve-Path  ".\watermark\watermark.png").Path
$gmExecutablePath = (Resolve-Path  ".\gm\gm.exe").Path


Function process ($inputFolder, $outFolder, $watermarkFilePath) {
	$dissolveFactor = 35
	$jpgQuality = 65
	Get-ChildItem $inputFolder\* -Include *.jpeg, *.jpg | foreach {
		$srcFilePath = Join-Path $inputFolder $_.Name
		$destFilePath = Join-Path $outFolder $_.Name
		echo $destFilePath
		Try {
			& $gmExecutablePath composite -dissolve $dissolveFactor -quality $jpgQuality -tile $watermarkFilePath $srcFilePath $destFilePath
		} Catch {
			$ErrorMessage = $_.Exception.Message
			echo "Error watermarking $srcFilePath message: $ErrorMessage" 
		}
	}
}

echo "Starting conversion"
process $inputFolder $outFolder $watermarkFilePath
echo "Conversion finished"